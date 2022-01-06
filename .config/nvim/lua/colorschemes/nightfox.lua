local status_ok, nf = pcall(require, 'nightfox')
if not status_ok then
  return
end

nf.load('nordfox')
