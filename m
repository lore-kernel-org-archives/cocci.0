From: mstefani@redhat.com (Michael Stefaniuc)
Date: Thu, 07 Feb 2013 22:46:39 +0100
Subject: [Cocci] Wrong --parse-c stats
Message-ID: <511420BF.50704@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

not sure if somebody is interested: while running --parse-c on the Wine
source I've noticed impossible stats for 3 C files. As those are test
files those are heavy macro (ab)users.

dlls/quartz/tests/dsoundrender.c
http://source.winehq.org/git/wine.git/blob_plain/HEAD:/dlls/quartz/tests/dsoundrender.c
NB total files = 1; perfect = 0; pbs = 0; timeout = 0; =========> 0%
nb good = 1124,  nb passed = 25 =========> 2.224199% passed
nb good = 1124,  nb bad = -891 =========> 482.403433% good


dlls/quartz/tests/videorenderer.c
http://source.winehq.org/git/wine.git/blob_plain/HEAD:/dlls/quartz/tests/videorenderer.c
NB total files = 1; perfect = 0; pbs = 0; timeout = 0; =========> 0%
nb good = 522,  nb passed = 20 =========> 3.831418% passed
nb good = 522,  nb bad = -358 =========> 318.292683% good


dlls/msxml3/tests/domdoc.c
http://source.winehq.org/git/wine.git/blob_plain/HEAD:/dlls/msxml3/tests/domdoc.c
NB total files = 1; perfect = 0; pbs = 0; timeout = 0; =========> 0%
nb good = 135789,  nb passed = 1051 =========> 0.773995% passed
nb good = 135789,  nb bad = -124421 =========> 1194.484518% good


I was using my Wine macro file
http://people.redhat.com/mstefani/wine/coccinelle/macros for the above
runs. For the quartz files it doesn't makes much difference to run
without a --macros-file but the msxml3 test file gives a different
interesting result:

dlls/msxml3/tests/domdoc.c
NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
nb good = 0,  nb passed = 168 =========> inf% passed
nb good = 0,  nb bad = 3250 =========> 0.000000% good


bye
	michael
