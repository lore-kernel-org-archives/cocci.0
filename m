From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 2 Dec 2013 16:57:41 +0100
Subject: [Cocci] [PATCH 2/2] coccinelle: add .gitignore file
In-Reply-To: <1385999169-19497-2-git-send-email-mcgrof@do-not-panic.com>
References: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
 <1385999169-19497-2-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6UVsYBk3sENEtQdHWA4iYwQvHFKPLS70PdbtuOsge=QgQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Dec 2, 2013 at 4:46 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Stash into it a series of files which we do not need
> to keep track via git as they are generated upon build
> time and can be system specific.

Additionally the .gitignore file can be extended with all files or
globals (*.cmo) for files that we should not be keeping track of but I
would prefer someone more familiar with the ocaml and the project to
groom this. In short, 'git status' should not output anything, even
after I compiled the project -- just as after I compile a Linux kernel
and run git status on LInux tree its empty.

  Luis
