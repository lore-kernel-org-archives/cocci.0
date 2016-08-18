From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Aug 2016 05:00:24 -0400 (EDT)
Subject: [Cocci]
	=?utf-8?q?=E2=80=9Ccoccicheck_failed=E2=80=9D_during_para?=
	=?utf-8?q?llel_program_runs?=
In-Reply-To: <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
 <99082e9d-8047-eee3-68dd-9849868d4a96@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608180458020.3107@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It seems that make coccicheck interprets anything being written on
standard error as a fatal error.  This seems like a strange point of view,
as Coccinelle needs somewhere to print warnings that the user may also
find useful.  But I have changed Coccinelle such that it prints this
particular warning in a different way that will cause it to disappear when
the option --very-quiet is used.  You can find the solution in the latest
commit on github.

thanks,
julia
