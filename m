From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Nov 2017 12:15:28 +0100 (CET)
Subject: [Cocci] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <533ab049-900c-fbb7-04e0-8dfaef492847@users.sourceforge.net>
References: <alpine.DEB.2.20.1711140735020.2332@hadrien>
 <e1d8885a-4e3f-a980-00d8-76515d02da17@users.sourceforge.net>
 <alpine.DEB.2.20.1711141009250.2874@hadrien>
 <533ab049-900c-fbb7-04e0-8dfaef492847@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1711141210560.2874@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Nov 2017, SF Markus Elfring wrote:

> >>> I didn't want to use a name with the pid, so that one could easily find
> >>> this information while Coccinelle is running.
> >>
> >> Do you mark these data as ?hidden? in the file system?
> >
> > I don't know what this means.
>
> Do you fiddle with file attributes or use a dot as the first character
> in the file name?

The goal is that the user can easily find the stdou and stderr information
while the semantic patch is running.  This is useful for long running
semantic patches to see if things are going well or not.

I decided on creating a directory that contains the name of the semantic
patch, then the date, then the pid.  It should be easy for the user to see
which is the most recent, in the case that previous instances are
remaining.

> This might be. - Or do they compare different software versions (in parallel)?

It's only an issue when they have the same name and are run from the same
directory.

> > Those people won't realize that they should use such extra options either.
>
> Some time is needed to become more aware about advanced parameters.

The goal is to avoid getting a mysterious error from make coccicheck, not
to meet the needs of advanced users.

julia
