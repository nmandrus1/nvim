-- require('onedark').setup {
--   style = 'cool'
-- }

local ok, onedark = pcall(require, "onedark")

if not ok then
  return
end

onedark.load()
