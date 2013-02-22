From: mmarek@suse.cz (Michal Marek)
Date: Fri, 22 Feb 2013 11:41:43 +0100
Subject: [Cocci] [PATCH 2 1/2] coccicheck: Allow the user to give a
	V=	(verbose) argument
In-Reply-To: <20130129160342.28754.96853.stgit@localhost.localdomain>
 <20130129160337.28754.31558.stgit@localhost.localdomain>
References: <20130129160342.28754.96853.stgit@localhost.localdomain>
 <20130129160337.28754.31558.stgit@localhost.localdomain>
Message-ID: <20130222104143.GE12402@pobox.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 29, 2013 at 05:03:37PM +0100, Bernd Schubert wrote:
> Do not run with verbosity on/off depending on the ONLINE variable,
> which gets set with C=1 or C=2, but allow the user to set the
> verbosity using kernel default make V= paramemter.
> Verbosity is off by default now.

On Tue, Jan 29, 2013 at 05:03:42PM +0100, Bernd Schubert wrote:
> On my system one of the tests failed with
> "Fatal error: exception Failure("No OCaml compiler found! Install either ocamlopt or ocamlopt.opt")".
> 
> Investigating such issues is easier if the executed command line is being shown.

I applied both patches to kbuild.git#misc, thanks.

Michal
