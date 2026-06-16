if not os.getenv("KITTY_WINDOW_ID") then
    return
end

local lockfile = "/tmp/kitty_small_font"

local function read_count()
    local f = io.open(lockfile, "r")
    if not f then return 0 end
    local n = tonumber(f:read("*n")) or 0
    f:close()
    return n
end

local function write_count(n)
    local f = io.open(lockfile, "w")
    if f then
        f:write(tostring(n))
        f:close()
    end
end

local augroup = vim.api.nvim_create_augroup("KittyFont", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup,
    callback = function()
        local count = read_count()
        write_count(count + 1)
        if count == 0 then
            vim.fn.system("kitten @ set-font-size 10")
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    group = augroup,
    callback = function()
        local count = read_count()
        local new_count = math.max(0, count - 1)
        write_count(new_count)
        if new_count == 0 then
            vim.fn.system("kitten @ set-font-size 0")
        end
    end,
})
