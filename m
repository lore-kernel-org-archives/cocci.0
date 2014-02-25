From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Feb 2014 18:42:30 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530CD2C4.4050903@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1402251840450.7035@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 25 Feb 2014, SF Markus Elfring wrote:

> > I'm not sure to understand your goal.
>
> I get an interesting result for example if I try the following source code
> search pattern out. Do you find it useful?
>
> @Delete_unnecessary_checks@
> expression x;
> identifier release =~ "^(?x)
> (?:
>    (?:kz?|slob_)free
> |
>    (?:
>       abc
>    |  xyz
>    )
> )$";
> @@
> -if (x)
>     release(...,x,...);
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
> delete_unnecessary_checks1.cocci /usr/src/linux-stable/fs/btrfs/inode.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: /usr/src/linux-stable/fs/btrfs/inode.c
> diff =
> --- /usr/src/linux-stable/fs/btrfs/inode.c
> +++ /tmp/cocci-output-3740-5d95d8-inode.c
> @@ -5137,8 +5137,7 @@ static int btrfs_dentry_delete(const str
>
>  static void btrfs_dentry_release(struct dentry *dentry)
>  {
> -       if (dentry->d_fsdata)
> -               kfree(dentry->d_fsdata);
> +       kfree(dentry->d_fsdata);
>  }
>
>
> > If you remove the NULL test, you could drastically change the behavior
> > of the program.
>
> But it seems that I stumble on a software debug challenge after I replaced the
> dummy alternation in the regular expression above by the real list of 5142
> function names which were found by the other discussed pattern.
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
> delete_unnecessary_checks2.cocci /usr/src/linux-stable/fs/btrfs/inode.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> Fatal error: exception Pcre.Error(_)

I don't think it is a good approach to do anything related to 5142
different functions at once.  It would be better to pick a small set of
functions, and work on them carefully.

julia
