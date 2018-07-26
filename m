From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 14:52:58 -0500
Subject: [Cocci] Perforce support,
	or generating list of files that would be changed?
Message-ID: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I need to run the "p4 edit" command before spatch can modify any file.
Is there a way to do either of the following:

1. Provide a list of files that "spatch --in-place --dir ." would edit
2. Have spatch run the "p4 edit" command on a file before changing it
