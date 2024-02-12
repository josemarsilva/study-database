SELECT type, type_desc, name, count(1)
FROM   sys.objects
GROUP  BY type, type_desc, name
GO