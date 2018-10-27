From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 27 Oct 2018 08:38:02 +0200 (CEST)
Subject: [Cocci] sending out trewide patches
Message-ID: <alpine.DEB.2.21.1810270831160.3588@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

At OSS Europe, I got some questions about how to send out large
Coccinelle-generated patches.  Coccinelle provides a tool tools/splitpatch
(go to the tools subdirectory of the Coccinelle distribution and run make)
that splits patches by set of maintainers (the default), by directory
(--dirmerge option), or by file (--nomerge option).  There is a file
tools/splitpatch.README that explains the various ways that it can be
used, but the simplest is to create a patch normally using
git format-patch -s, obtaining eg 0001-changes.patch, and then run

splitpatch 0001-changes.patch

The output will include a 0001-changes.cover file, a set of
0001-changesN.patch files with the various split patches, and a
0001-changes.cmd file for sending it off with git send-email.

This is available in the latest github version of Coccinelle.  Comments
are welcome.

julia
