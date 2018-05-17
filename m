From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 10:45:27 -0400
Subject: [Cocci] exists do not work if file group is too big
In-Reply-To: <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
References: <20180516191634.GB2994@redhat.com>
 <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
Message-ID: <20180517144527.GA5048@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 09:33:09AM +0200, SF Markus Elfring wrote:
> > When operating on too many files the exists keyword no longer work.
> 
> How do you think about to show a more precise error message for one approach
> to add the preprocessor symbol ?NULL? as the first parameter in a call
> of the function ?set_page_dirty??

There is no error message in the issue i reported. Nested block are
just silently no longer modified just because there is too many files.

> 
> 
> > spatch ? --include fs/afs/internal.h ?
> 
> * I find the position of this command parameter unusual.

I am using git grep to find files which reference the symbols i am
modifying and i am doing a bit of sed regular expression on its out-
put to prepend header files with --include

In the end i probably will have 40-50 semantics patches and i do not
wish to create by hand a list of files to modify especialy as if i
do so then i loose the big selling point of coccinelle ie not having
to worry about rebasing patches if things move around.

> 
> * Are you sure that you would like to adjust the selected source files
>   by a single command?

So as i am modifying a lot of functions which are close in sources
files, i am getting error with --in-place with headers files, i could
spit a patch and use patch -r - -f ... to force thing but this not only
complexify the whole set of commands needed to run, it also fails in
more sublte way (when doing twice the same modification which can lead
to missing chunk modification).

This is why i am gretting groups of files to modify one function at a
time and i also pass the function name to coccinelle using -D fn=name

I have try many ways to do this and after coupls weeks of iterations
this is the cleanest simplest, fastest solution i converged on.

> 
> * Would you like to pass any file name to a command variant in a loop?

I would not see the benefit in that, i use --no-includes in my command
line and modification are pretty fast so i am roughly happy as it is :)

Hopes this feedback helps. My biggest issue with coccinelle is the lack
of support for function pointer typedef. Otherwise it is a pretty smooth
experience. I have also an issue with python execution but this might be
a fedora packaging issue, i have a local patch that make it works in
fedora 27 but i need to check coccinelle git first to see if it is still
an issue in lastest version. I need to inspect fedora spec file too.

Big kudos to everyone working on this tools.

Cheers,
J?r?me
