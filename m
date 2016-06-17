From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 17 Jun 2016 17:12:29 +0200
Subject: [Cocci] [PATCH v2 3/8] coccicheck: add indexing enhancement
	options
In-Reply-To: <alpine.DEB.2.10.1606171146360.3164@hadrien>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-4-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606171146360.3164@hadrien>
Message-ID: <20160617151229.GO11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 17, 2016 at 11:47:25AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 16 Jun 2016, Luis R. Rodriguez wrote:
> 
> > Coccinelle has support to make use of its own enhanced "grep"
> > mechanisms instead of using regular grep for searching code,
> > it calls this 'coccigrep'. In lack of any indexing optimization
> > information it uses --use-coccigrep by default.
> >
> > This patch enable indexing optimizations heuristics so that coccigrep
> > can automatically detect what indexing options are available and use
> > them accordinly without any user input.
> >
> > Since git has its own index, support for using 'git grep' has been
> > added to Coccinelle, that should on average perform better than
> > using the internal coccigrep. Coccinelle has had idutils support
> > as well for a while now, you however need to refer to the index
> > file. We support detecting two idutils index files by default,
> > ID and .id-utils.index, assuming you ran either of:
> >
> >  # What you might have done:
> > mkid -s
> >  # as in coccinelle scripts/idutils_index.sh
> > mkid -i C --output .id-utils.index *
> >
> > Lastly, Coccinelle has had support for glimpseindex for a long while,
> > however the glimpseindex tool, the agrep library were previously closed
> > source, its all now open sourced, and provides the best performance, so
> > support that if we can detect you have a glimpse index.
> >
> > You can always override the index as follows:
> >
> > $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"
> 
> Why not just have a generic COCCI_ARGS argument?

Actually SPFLAGS exists already so we can just document to
override using that. Will fix.

  Luis
