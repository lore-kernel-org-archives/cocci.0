From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jul 2018 22:26:59 +0200 (CEST)
Subject: [Cocci] Perforce support,
 or generating list of files that would be changed?
In-Reply-To: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
References: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807262225450.6047@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> I need to run the "p4 edit" command before spatch can modify any file.
> Is there a way to do either of the following:
>
> 1. Provide a list of files that "spatch --in-place --dir ." would edit

I'm not sure to understand what you are asking for here.

> 2. Have spatch run the "p4 edit" command on a file before changing it

I don't think so.  Maybe you could make a script to do this.

julia
