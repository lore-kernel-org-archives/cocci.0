Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCC6C433F5
	for <cocci@archiver.kernel.org>; Tue,  1 Mar 2022 02:02:05 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,144,1643670000"; 
   d="scan'208";a="23696063"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2022 03:02:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B96BDE0380; Tue,  1 Mar 2022 03:02:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24034E037F
	for <cocci@sympa.inria.fr>; Tue,  1 Mar 2022 03:02:01 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: T8YsrJGBt8SzINGqWPRVz0DYZK7hjWMu+uyoSBYI6C7kZIEmPcTyW5qy6OvQg6cr5ma9u1H8RZ
 AFUUDQ6SdirM9UF7TgXiCMju7VsOTxnsHxMupvoc3Bn/Lv+BHNxmpsiA7od3ItBC3tiTISO9vu
 LVJgvNjTJvKRRRXrC/ZDYxPXi3SX/ZGiUL/is2ilipcvsCEKLIfeuTMork1/4aMA+SOkipPcTv
 RM2oE/7ZiwXDnNR0nqb4AyRbZdx4rILlEnHOokQ0veFnHngB7e6uHrbwptRJ9WYp42pkXabM7Z
 FREPXHbz0qpcJ+lrNsELFH4a
X-IPAS-Result: =?us-ascii?q?A0AxBQDPfR1i/0Xcza1agQmEAgd3VgEBASkEC0SVPS4Dn?=
 =?us-ascii?q?lcLAQMBDTUMBAEBhQcChBECHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIDBAGBCCwBYwFnAYFOAYF5BgQwDYI1KQGDYwEBAQECAScTDzAFCwsYL?=
 =?us-ascii?q?lcGgxcBgnUhD61TeIEBMoEBg08BhiuBPIYSE0KHXSccQIFNgRUnglMwPoJMF?=
 =?us-ascii?q?wICh1sElUl8Eyx7SjkhHAI6n3aCE54Rg1KLB5RMBhQulkORYpZSjRKUK4U4g?=
 =?us-ascii?q?T85JYFZHxQaCCYKgyQJRQECAQIBDAECAgECAQIBAgEIAQECAY4oFoNQhRSFa?=
 =?us-ascii?q?yABAQExOAIGCwEBAwmTDQEB?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23:5usGA6yL6TTdt/sgGP96t+cOwCrEfRIJ4+MujC+fZmUNrF6WrkUHy
 2AbWjqBM/nbajPyLdwnPY6w8hsPvMTdy9JgTFNurVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvX4
 4Oq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhI6
 Mdk5Ie9RzwWBe7Uu9gFFAZ5QzBxaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY2ZoUQK+CO
 6L1bxJhPQ/wQhRtGG0yDYgOufWHlnSmIwFx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb34T6M7XuogsfdnCbxQotUFbui9/csjkf7+4AIIBgGE1akofS0jkOkHdRSN
 yT45xbCs4AL1F6CH8LwUSaHmz2cnSIEHMVxQ/w1vVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlj+8FFhQ07+LIESP1GqO86GLtaXJMfAfucAddFVNdi+QPtr3fmf4mczqOOKulyNDqGTz9x
 z2Q6i4zm93/bPLnNY3gojgrYBr2+vAlqzLZAC2NBgpJCSskDLNJn6TytTDmAQ9ode50jjCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bbGOE3gU1RcB+qmzFF5ufkWZ4u20WyKBBaZlsRNMUS
 BWO52u9GrcMVJdVUUOHS9ntVZ97kviI+SXNW+/UY9dKb4JwcgTCpHgGWKJj9zuFraXt+IlhU
 aqmnTGEVi5LWfw6l2PtH4/wE9YDn0gD+I8afrijpzzP7FZUTCf9pW4tPATcY+YnwrmDpQmJo
 d9TO9HTm0dbUfbieW/a7o4eIFQHNz49CIyv855bceuKIwxHHmA9CqaLneh7I9E8w/1YxrXS4
 3Wwek5E016h13fJHgW9dSwxYr3YW5si/2kwOjYhPAv21iF7M5qv9qoWa7A+YaIjqL541fdxQ
 vRcI5eAD/1DRy7p4TMYaZWh/oVueA7y1VCKPjG5e34yYJ5tSgjE4Jnicxe2rHsCCS++tM0fp
 by811qBHcFZH1k7UJ/bMav9wUmwsH4RnPNJc3HJetQDKl/x9IVKKjDqiqFlKc87KSLcmmmQ2
 TGQDEpKvuLKuYI0rYfE3PjWs4ezHuJiNUNGBG2Hv62uPCzX82f/k49NVOGEIWLUWG/uofjwY
 PUTwu78PfADkUwMtYdgSu45waU77trphrlb0gU9RimQNQz2U+85LynUx9RLu41M2qRd51m8V
 HWPzcYGa7+HD8XoTQwKLw0/Y+Xei/xNwmvO7e44KVnR7TNs+ObVSl1bOhSB1H5HIL1uPN93y
 OstopdLuQmvzBc1MtuLii1OsWKBMiVYAakgs5gbBq7tixYqkwseOsaEV3aquZzfOc9RNkQKI
 yOPgPSQjbprxn3dLyg5G0/L0LcPnp8Joh1LkQEPfgzbhtrfi/Yr9xRN6jBrHB9NxxBK3u8b1
 rKH7KGpyXFiPguEhfSvm0ipC0dMGx2U90j80R0PmXGxo4xEkIDSBDVVBApP1BlxH6Fgkvxz+
 LCD1H2jXCnqccz10zF0X0N5wxAmoRqd6SWa8P1K3K25810SZTv+nrToaHUIphbjDNl3gkDbz
 QWvECCcdoWjXRMtT2YH50V2GFjepN1o5ICPfB25wJ40IA==
IronPort-HdrOrdr: A9a23:YbxHiK/Xft2j7wj1kYBuk+DeI+orL9Y04lQ7vn1ZYhZeG/bo8f
 xG/c5rsiMc7Qx6ZJhOo6HiBEDtexPhHP1OgLX5X43SPjUO0VHAROpfBODZsljd8kPFh4pgPG
 RbH5SWyuecMbG3t6nHCcCDfeod/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,144,1643670000"; 
   d="scan'208";a="7225144"
X-MGA-submission: =?us-ascii?q?MDHUTUhCS5oAb48Gm4QvX2qAF6pCzFw1tc5gNl?=
 =?us-ascii?q?65q4Fme+sI5abrRneHq9ilK7cdD2iQpfQcXp60QwRT/tPhfAkqyBFjHc?=
 =?us-ascii?q?ZWV+z8CRPn7LfXd1LGB/I/kxaQca8ehNwZMWk0uxd0uz2oEl95OgrRWV?=
 =?us-ascii?q?z9VStfQIzzi75oMNNWE99b1A=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 03:02:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id F2CB84A;
	Mon, 28 Feb 2022 18:01:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r8ZaqSEtKR5P; Mon, 28 Feb 2022 18:01:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6A2D639;
	Mon, 28 Feb 2022 18:01:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6A2D639
Date: Mon, 28 Feb 2022 18:01:50 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net>
Message-ID: <ff76e0b6-d7cd-de3a-ec2d-b1b1492e2e69@ewheeler.net>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net> <alpine.DEB.2.22.394.2202280705080.3112@hadrien> <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 158
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ff76e0b6-d7cd-de3a-ec2d-b1b1492e2e69%40ewheeler.net>

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


Ok so this worked in the simple example .c file:
	@ rule1 @
	typedef data_t;
	global idexpression data_t I = {data};
	identifier j;
	@@
	-I@j
	+nec->j

But when I try it on the actual code base I get this:
	]# spatch --sp-file nec-refactor2.cocci src/xnec2c.c
	init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
	(ONCE) Expected tokens data_t
	Skipping: src/xnec2c.c

I have tried:
  * adding `-I src/`
  * adding `--include src/common.h --include src/shared.h` where data_t is defined.
  * adding --include-headers-for-types
  * adding --recursive-includes
  * Removing the `global` specifier on the idexpression.

None of these seem to work, they all skip with the "(ONCE) Expected tokens data_t" error.

However, if I hack "data_t data;" into the top of xnec2c.c then it works.

There seems to be a problem finding the `data_t data` definition through the headers.  

What should I do?  Here is the .c file if you want to take a look:
	https://github.com/KJ7LNW/xnec2c/blob/master/src/xnec2c.c

and the .h file with data_t:
	https://github.com/KJ7LNW/xnec2c/blob/master/src/shared.h#L219

Here is the version:

]# spatch --version
spatch version 1.1.1-00044-gb2a4b9b compiled with OCaml version 4.05.0
Flags passed to the configure script: --prefix=/usr/local/coccinelle-git
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

> What does I@j mean?  Can you point me at documentation?

-Eric
