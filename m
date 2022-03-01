Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD66C433EF
	for <cocci@archiver.kernel.org>; Tue,  1 Mar 2022 06:09:11 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,145,1643670000"; 
   d="scan'208";a="23710410"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2022 07:09:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D9ACE037F; Tue,  1 Mar 2022 07:09:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B62EE037F
	for <cocci@sympa.inria.fr>; Tue,  1 Mar 2022 07:09:05 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,145,1643670000"; 
   d="scan'208";a="7232426"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:09:05 +0100
Date: Tue, 1 Mar 2022 07:09:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203010703590.3160@hadrien>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net> <alpine.DEB.2.22.394.2202280705080.3112@hadrien> <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 159
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203010703590.3160%40hadrien>



On Mon, 28 Feb 2022, Eric Wheeler wrote:

> On Mon, 28 Feb 2022, Julia Lawall wrote:
> > On Sun, 27 Feb 2022, Eric Wheeler wrote:
> >
> > > Hello,
> > >
> > > Can I match only specific identifier types and names where the type is a
> > > typedef? I've been reading as much as I can about Coccinelle but I've not
> > > found a way to do it.
> > >
> > > I'm trying to move global calculation structures into its own typedef
> > > structure to create a thread-safe environment where multiple threads can
> > > work on different struct instances.  Right now the code works only on
> > > static global values so parallelism is not possible without fork()ing.
> > > (This is for the www.xnec2c.org project.)
> > >
> > > The code that looks pretty close to the following:
> > >
> > > 	// Globals
> > > 	typedef struct {
> > > 		int a;
> > > 	} data_t
> > >
> > > 	data_t data;
> > >
> > > 	void f(char *data)
> > > 	{
> > > 		data[0] = 0; // parameter
> > > 	}
> > >
> > > 	void g()
> > > 	{
> > > 		data.a = 0; // global
> > > 	}
> > >
> > > I want to put all of the global 'data' variables of type 'data_t' into a
> > > new structure as follows:
> > >
> > > 	typedef struct {
> > > 		data_t data;
> > > 		// and many others...
> > > 	} nec_t;
> > >
> > > 	nec_t *nec;
> > >
> > > and replace the functions above as:
> > >
> > > 	void f(char *data)
> > > 	{
> > > 		data[0] = 0; // Does NOT change
> > > 	}
> > >
> > > 	void g()
> > > 	{
> > > 		nec->data.a = 0; // This DOES change
> > > 	}
> > >
> > > With a rule something like this:
> > >
> > > 	@ rule1 @
> > > 	typedef data_t;
> > > 	type T = {data_t};
> > > 	identifier I = {data};
> >
> > This means that your variable I should always be called "data".  Is that
> > what you intended?
> >
> > You should be able to do
> >
> > idexpression data_t I = {data};
> >
> > Then you want to use the name in a structure field.  Te problem is that a
> > structure field is not an expression, it is an identifier.  So you have to
> > make the match in two ways:
> >
> > @@
> > idexpression data_t I = {data};
> > identifier j;
> > @@
> >
> > -I@j
> > +nec->j
>
> Thanks Julia, that seems to work (I added `typedef data_t;` to the .cocci
> file).
>
> What does I@j mean?  Can you point me at documentation?

Match a thing according to both I and j.  It's like for position
variables.  One may write e@p to both match the expression e and get its
position.

This is discussed on page 6 in the documentation that is on the Coccinelle
web page:

https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf

A position metavariable is used by attaching it using @ to any token,
including another metavariable. Its value is the position (file, line
number, etc.) of the code matched by the token. It is also possible to
attach expression, declaration, type, initialiser, and statement
metavariables in this manner. In that case, the metavariable is bound to
the closest enclosing expression, declaration, etc. If such a metavariable
is itself followed by a position metavariable, the position metavariable
applies to the metavariable that it follows, and not to the attached
token. This makes it possible to get eg the starting and ending position
of f(...), by writing f(...)@E@p, for expression metavariable E and
position metavariable p. This attachment notation for metavariables of
type other than position can also be expressed with a conjunction, but the
@ notation may be more concise.
