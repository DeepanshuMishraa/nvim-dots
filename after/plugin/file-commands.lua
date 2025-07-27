-- Custom file management commands

-- Delete command that finds files intelligently
vim.api.nvim_create_user_command('Delete', function(opts)
    local filename = opts.args
    
    -- If no filename provided, error out
    if filename == '' then
        vim.notify('Usage: :Delete <filename>', vim.log.levels.ERROR)
        return
    end
    
    -- Get the current directory context
    local current_dir = vim.fn.expand('%:p:h')
    
    -- If in netrw, use the netrw directory
    if vim.bo.filetype == 'netrw' then
        current_dir = vim.b.netrw_curdir or vim.fn.getcwd()
    end
    
    -- Try to find the file
    local full_path
    
    -- First, check if it's an absolute path
    if vim.fn.filereadable(filename) == 1 then
        full_path = vim.fn.expand(filename)
    -- Then check in current directory
    elseif vim.fn.filereadable(current_dir .. '/' .. filename) == 1 then
        full_path = current_dir .. '/' .. filename
    -- Finally check in working directory
    elseif vim.fn.filereadable(vim.fn.getcwd() .. '/' .. filename) == 1 then
        full_path = vim.fn.getcwd() .. '/' .. filename
    else
        -- Try to find the file using glob
        local found_files = vim.fn.glob(current_dir .. '/**/' .. filename, false, true)
        if #found_files > 0 then
            if #found_files == 1 then
                full_path = found_files[1]
            else
                -- Multiple files found, show options
                vim.ui.select(found_files, {
                    prompt = 'Multiple files found. Select one to delete:',
                    format_item = function(item)
                        return vim.fn.fnamemodify(item, ':.')
                    end
                }, function(choice)
                    if choice then
                        vim.cmd('Delete ' .. vim.fn.fnameescape(choice))
                    end
                end)
                return
            end
        else
            vim.notify('File not found: ' .. filename, vim.log.levels.ERROR)
            return
        end
    end
    
    -- Confirm deletion
    local relative_path = vim.fn.fnamemodify(full_path, ':.')
    local confirm = vim.fn.confirm('Delete ' .. relative_path .. '?', '&Yes\n&No', 2)
    
    if confirm == 1 then
        -- Close buffer if file is open
        local buf_nr = vim.fn.bufnr(full_path)
        if buf_nr ~= -1 and vim.api.nvim_buf_is_loaded(buf_nr) then
            vim.api.nvim_buf_delete(buf_nr, { force = true })
        end
        
        -- Delete the file
        local success = vim.fn.delete(full_path)
        if success == 0 then
            vim.notify('Deleted: ' .. relative_path, vim.log.levels.INFO)
            
            -- Refresh netrw if we're in it
            if vim.bo.filetype == 'netrw' then
                vim.cmd('e ' .. vim.fn.fnameescape(current_dir))
            end
        else
            vim.notify('Failed to delete: ' .. relative_path, vim.log.levels.ERROR)
        end
    end
end, { nargs = 1, complete = 'file' })

-- Optional: Add a mapping for quick access
vim.keymap.set('n', '<leader>d', ':Delete ', { desc = 'Delete file' })