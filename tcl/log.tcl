
## Copyright (c) 2014 Quanta Research Cambridge, Inc.

## Permission is hereby granted, free of charge, to any person
## obtaining a copy of this software and associated documentation
## files (the "Software"), to deal in the Software without
## restriction, including without limitation the rights to use, copy,
## modify, merge, publish, distribute, sublicense, and/or sell copies
## of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:

## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.

## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
## NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
## BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
## ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
## CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.


proc log_command { command { logfile ""}} {
    global commandfilehandle

    puts "$command"
    puts $commandfilehandle "$command"
    if { [cat "$command > $logfile" errMessage] } {
	show_errors $logfile
	error $errMessage
    }
    show_errors $logfile
}

proc show_errors { logfile } {
    global errorfilehandle
    if {[file exists $logfile]} {
	set loghandle [open $logfile r]
	set logmessages [read $loghandle]
	close $loghandle
	foreach logmessage [split $logmessages '\n'] {
	    if [string match "CRITICAL WARNING*" $logmessage] {
		puts "\t$logmessage"
		puts $errorfilehandle "$logmessage"
	    }
	    if [string match "ERROR:*" $logmessage] {
		puts "$logmessage"
		puts $errorfilehandle "$logmessage"
	    }
	}
    }
}