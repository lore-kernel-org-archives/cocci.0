From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Tue, 3 Oct 2017 14:26:51 +0200
Subject: [Cocci] make install broken
Message-ID: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

while my Makefile patch lets make install finish a lot of stuff is missing:
spatch foo.cocci foo.c
warning: Can't find macro file: ./../lib/coccinelle/standard.h
warning: Can't find default iso file: ./../lib/coccinelle/standard.iso
Python error: No module named 'coccilib'

Only this stuff gets installed:
find /usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spatch
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/bin/spgen
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/lib/coccinelle/dllpyml_stubs.so
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d
/usr/local/packages/coccinelle-1.0.6-318-g0bf5304/etc/bash_completion.d/spatch


bye
         michael
