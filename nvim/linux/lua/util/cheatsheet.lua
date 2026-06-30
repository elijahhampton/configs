local M = {}

local state = { win = nil, buf = nil }

local lines = {
  "─ Motions ─",
  "  h j k l        char L/D/U/R",
  "  w b e          word fwd/back/end",
  "  W B E          WORD (whitespace)",
  "  0 ^ $          line start/first/end",
  "  gg G           file top/bottom",
  "  { }            paragraph up/down",
  "  ( )            sentence",
  "  H M L          screen top/mid/bot",
  "  zz zt zb       center/top/bot view",
  "  Ctrl-d / u     half page down/up",
  "  Ctrl-f / b     full page",
  "  Ctrl-o / i     jump back / forward",
  "  %              match bracket",
  "  f/F/t/T <c>    find char on line",
  "  ; ,            repeat f/t fwd/back",
  "  ma  `a  'a     mark / jump / line",
  "",
  "─ Search & Replace ─",
  "  / ?            search fwd / back",
  "  n N            next / prev match",
  "  * #            word under cursor",
  "  :%s/a/b/g      replace in file",
  "  :%s/a/b/gc     replace + confirm",
  "  :s/a/b/g       replace in line",
  "  :'<,'>s/a/b/g  replace in selection",
  "  :noh           clear highlight",
  "  Esc            clear highlight (custom)",
  "",
  "─ Edit ─",
  "  i a I A        insert / append",
  "  o O            new line below / above",
  "  r R            replace char / mode",
  "  x X            delete char / before",
  "  dd D           delete line / to EOL",
  "  cc C s S       change line/EOL/char/line",
  "  yy Y           yank line",
  "  p P            paste after / before",
  "  u Ctrl-r       undo / redo",
  "  .              repeat last edit",
  "  J              join lines",
  "  >> << ==       indent / auto-indent",
  "  gU gu ~        upper / lower / toggle",
  "  Ctrl-a Ctrl-x  inc / dec number",
  "  ZZ ZQ          save+quit / quit no save",
  "",
  "─ Visual Mode ─",
  "  v V Ctrl-v     char / line / block",
  "  gv             reselect last",
  "  o              swap cursor end",
  "  J K            move selection (custom)",
  "  < >            indent (sticky, custom)",
  "  =              auto-indent selection",
  "  d c y          delete / change / yank",
  "",
  "─ Text Objects (use with d/c/y/v) ─",
  "  iw aw          word / WORD",
  "  i\" a\" i' a'    quotes",
  "  i( a( i{ a{    brackets",
  "  i[ a[ i< a<    brackets",
  "  ip ap          paragraph",
  "  it at          html tag",
  "  if af ic ac    function / class (TS)",
  "  ia aa          argument (TS)",
  "  Ctrl-Space     incremental select (TS)",
  "  ]f [f ]c [c    next/prev fn / class",
  "",
  "─ Files & Buffers ─",
  "  :e <file>      edit file",
  "  :w :wa         save / save all",
  "  :q :qa :qa!    quit / all / force",
  "  :wq            save & quit",
  "  :bd            close buffer",
  "  Shift-h / l    prev / next buffer",
  "  <leader>bd     close buffer",
  "  -              oil parent dir",
  "  <leader>e      file tree toggle",
  "  <leader>E      reveal file in tree",
  "",
  "─ Find (Telescope) ─",
  "  <leader>ff     find files",
  "  <leader>fg     live grep (project)",
  "  <leader>fb     buffers",
  "  <leader>fr     recent files",
  "  <leader>fs     symbols (file)",
  "  <leader>fS     symbols (workspace)",
  "  <leader>fd     diagnostics",
  "  <leader>fk     keymaps",
  "  <leader>fc     commands",
  "  <leader>fh     help tags",
  "  Ctrl-p         find files (alt)",
  "",
  "─ Windows ─",
  "  :sp :vsp       split / vsplit",
  "  Ctrl-h/j/k/l   move (custom)",
  "  Ctrl-w =       equalize sizes",
  "  Ctrl-w o       only this window",
  "  Ctrl-w q       close window",
  "  Ctrl-w r       rotate",
  "  Ctrl-w T       move to new tab",
  "",
  "─ LSP / IDE ─",
  "  gd             goto definition",
  "  gD             goto declaration",
  "  gr             references",
  "  gi             implementation",
  "  gy             type definition",
  "  K              hover docs",
  "  Ctrl-k         signature help",
  "  <leader>rn     rename symbol",
  "  <leader>ca     code action",
  "  <leader>cf     format buffer/sel",
  "  [d ]d          prev / next diagnostic",
  "  <leader>cd     line diagnostic float",
  "  <leader>lr     restart LSP",
  "",
  "─ Trouble (errors panel) ─",
  "  <leader>xx     workspace diagnostics",
  "  <leader>xX     buffer diagnostics",
  "  <leader>xs     symbols panel",
  "  <leader>xl     LSP refs/defs panel",
  "  <leader>xQ     quickfix list",
  "  <leader>xL     location list",
  "",
  "─ Git ─",
  "  ]h [h          next / prev hunk",
  "  <leader>gh     preview hunk",
  "  <leader>gr     reset hunk",
  "  <leader>gS     stage buffer",
  "  <leader>gu     undo stage hunk",
  "  <leader>gs     git status (fugitive)",
  "  <leader>gb     git blame",
  "  <leader>gd     git diff split",
  "",
  "─ Surround (mini.surround) ─",
  "  saiw\"          add \" around word",
  "  sd\"            delete surrounding \"",
  "  sr\"'           replace \" with '",
  "  saip}          surround paragraph w/ {}",
  "",
  "─ Folds ─",
  "  za zA          toggle fold",
  "  zo zc          open / close",
  "  zR zM          open / close all",
  "",
  "─ Macros & Registers ─",
  "  qa ... q       record macro to a",
  "  @a  @@         play / replay last",
  "  \"ay  \"ap       reg a yank / paste",
  "  \"+y  \"+p       system clipboard",
  "  \"0p            last yank (not delete)",
  "  :reg           list registers",
  "",
  "─ Quickfix / Location ─",
  "  :copen :cclose qf list open/close",
  "  :cnext :cprev  next / prev",
  "  :lopen :lnext  location list",
  "",
  "─ Misc ─",
  "  :%y+           yank file to clipboard",
  "  :!cmd          run shell command",
  "  :r !cmd        read cmd output",
  "  gq             format text (motion)",
  "  Ctrl-z         suspend (fg to return)",
  "  :checkhealth   plugin diagnostics",
  "  :Lazy :Mason   plugins / LSP servers",
  "",
  "[ <leader>? toggle  •  q close ]",
}

local function compute_geometry()
  local width = 42
  local max_h = vim.o.lines - 4
  local height = math.min(#lines, max_h)
  return {
    relative = "editor",
    anchor = "NE",
    width = width,
    height = height,
    row = 1,
    col = vim.o.columns - 1,
    style = "minimal",
    border = "rounded",
    focusable = true,
    title = " Cheatsheet ",
    title_pos = "center",
    zindex = 50,
  }
end

function M.is_open()
  return state.win and vim.api.nvim_win_is_valid(state.win)
end

function M.close()
  if M.is_open() then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
end

function M.open()
  if M.is_open() then return end
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
    vim.bo[state.buf].modifiable = false
    vim.bo[state.buf].bufhidden = "hide"
    vim.bo[state.buf].filetype = "cheatsheet"
    vim.keymap.set("n", "q", M.close, { buffer = state.buf, silent = true, nowait = true })
    vim.keymap.set("n", "<Esc>", M.close, { buffer = state.buf, silent = true, nowait = true })
  end
  state.win = vim.api.nvim_open_win(state.buf, false, compute_geometry())
  vim.wo[state.win].winblend = 5
  vim.wo[state.win].cursorline = false
  vim.wo[state.win].number = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].signcolumn = "no"
  vim.wo[state.win].wrap = false
  vim.wo[state.win].foldenable = false
end

function M.toggle()
  if M.is_open() then M.close() else M.open() end
end

vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("cheatsheet_resize", { clear = true }),
  callback = function()
    if M.is_open() then
      vim.api.nvim_win_set_config(state.win, compute_geometry())
    end
  end,
})

return M
