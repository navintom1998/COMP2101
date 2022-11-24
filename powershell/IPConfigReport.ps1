get-ciminstance win32_networkadapterconfiguration | where-object ipenabled -eq true | format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSHostname, DNSServerSearchOrder -autosize
