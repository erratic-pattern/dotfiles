-- detect .influxql files as sql filetype
vim.filetype.add({
  extension = {
    influxql = "sql",
  },
})
