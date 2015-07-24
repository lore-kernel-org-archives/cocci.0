From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Fri, 24 Jul 2015 19:17:59 +0200
Subject: [Cocci] sys.path for Python?
In-Reply-To: <CA+MoWDoKWWOpuUj=YoYWgVT73rOKhrcJPWCt_f-ro085D1T9cw@mail.gmail.com>
References: <CA+MoWDoKWWOpuUj=YoYWgVT73rOKhrcJPWCt_f-ro085D1T9cw@mail.gmail.com>
Message-ID: <20150724171759.GN30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 24, 2015 at 07:09:59PM +0200, Peter Senna Tschudin wrote:
> Hi,
> 
> I'm writing a set of .cocci files that will use python. I'm making
> some helper function that I want to include in multiple files. I'm
> doing something like:
> 
> @initialize:python@
> @@
> from Common import *
> 
> which works fine, given spatch is called from the folder where
> Commom.py is. If I move to the folder where I want to run spatch, and
> try the same semantic patch it fails. The solution for now is:
> 
> @initialize:python@
> @@
> import sys
> sys.path.append("/home/peter/devel/git/the-conference/devel/featureccinelle/cocci-files/")
> from Common import *
> 
> So I ask:
> 
> - Can I access from Python the path to the semantic patch? Maybe I
> could get that from the cmdline of spatch but that would be
> complicated.
> 
> - Does it make sense to have a python command to extend the path to
> append the folder where the semantic patch is in?

Can you try

source_dir = os.path.abspath(os.path.dirname(__file__))
sys.path.append(source_dir)

  Luis
