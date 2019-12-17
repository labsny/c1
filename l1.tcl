set ns [new Simulator]
set tr [open l1.tr w]
$ns trace-all $tr
set nam [open l1.nam w]
$ns namtrace-all $nam	

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2mb 5ms DropTail
$ns duplex-link $n1 $n2 2mb 5ms DropTail
$ns duplex-link $n2 $n3 2mb 5ms DropTail
$ns queue-limit $n0 $n2 5
$ns queue-limit $n1 $n2 5

$ns color 1 Blue
$ns color 2 Red
set tcp0 [new Agent/TCP]
$tcp0 set class_ 2
$ns attach-agent $n0 $tcp0
set tcp1 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp1
$ns connect $tcp0 $tcp1

set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n1 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0

set ftp [new Application/FTP]
$ftp attach-agent $tcp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

$ns at 0.2 "$ftp start"
$ns at 0.2 "$cbr0 start"
$ns at 2.2 "$ftp stop"
$ns at 2.2 "$cbr0 stop"

proc finish { } {
global ns tr nam
$ns flush-trace
close $tr
close $nam
exec nam l1.nam &

exit 0
}
$ns at 2.2 "finish"
$ns run  
