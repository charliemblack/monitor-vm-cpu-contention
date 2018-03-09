This is script monitors the `vm.cpu.contention.cpu` over time.   Monitoring "vm.cpu.contention.cpu" is equivalent to monitoring "steal time" and can be used when the linux kernel isn't reporting "steal time".   If your vms kernel is reporting steal time please use that over this script.

If steal time is blocked on your guest OS one can review the "tools.guestlib.enableHostInfo" setting to see if it was disabled for security purposes.
