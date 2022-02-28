Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3728DC433F5
	for <cocci@archiver.kernel.org>; Mon, 28 Feb 2022 06:08:29 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="23477177"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Feb 2022 07:08:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F22FEE0384; Mon, 28 Feb 2022 07:08:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B7DDCE037F
	for <cocci@sympa.inria.fr>; Mon, 28 Feb 2022 07:08:23 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,142,1643670000"; 
   d="scan'208";a="7112684"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 07:08:23 +0100
Date: Mon, 28 Feb 2022 07:08:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2202280705080.3112@hadrien>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 156
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/alpine.DEB.2.22.394.2202280705080.3112%40hadrien>



On Sun, 27 Feb 2022, Eric Wheeler wrote:

> Hello,
>
> Can I match only specific identifier types and names where the type is a
> typedef? I've been reading as much as I can about Coccinelle but I've not
> found a way to do it.
>
> I'm trying to move global calculation structures into its own typedef
> structure to create a thread-safe environment where multiple threads can
> work on different struct instances.  Right now the code works only on
> static global values so parallelism is not possible without fork()ing.
> (This is for the www.xnec2c.org project.)
>
> The code that looks pretty close to the following:
>
> 	// Globals
> 	typedef struct {
> 		int a;
> 	} data_t
>
> 	data_t data;
>
> 	void f(char *data)
> 	{
> 		data[0] = 0; // parameter
> 	}
>
> 	void g()
> 	{
> 		data.a = 0; // global
> 	}
>
> I want to put all of the global 'data' variables of type 'data_t' into a
> new structure as follows:
>
> 	typedef struct {
> 		data_t data;
> 		// and many others...
> 	} nec_t;
>
> 	nec_t *nec;
>
> and replace the functions above as:
>
> 	void f(char *data)
> 	{
> 		data[0] = 0; // Does NOT change
> 	}
>
> 	void g()
> 	{
> 		nec->data.a = 0; // This DOES change
> 	}
>
> With a rule something like this:
>
> 	@ rule1 @
> 	typedef data_t;
> 	type T = {data_t};
> 	identifier I = {data};

This means that your variable I should always be called "data".  Is that
what you intended?

You should be able to do

idexpression data_t I = {data};

Then you want to use the name in a structure field.  Te problem is that a
structure field is not an expression, it is an identifier.  So you have to
make the match in two ways:

@@
idexpression data_t I = {data};
identifier j;
@@

-I@j
+nec->j

julia


> 	@@
> 	-I
> 	+nec->I
>
> But of course T isn't actually used in that cocci example, but I want to
> make sure that I is always of type T but I'm not sure how. I tried
> idexpression but either it is not intended for this purpose. This gives a
> cocci syntax error, so clearly I do not have it correct, but maybe it
> explains what I'm trying to do:
>
> 	@ rule1 @
> 	typedef data_t;
> 	type T = {data_t};
> 	idexpression T I = {data};
> 	@@
> 	-I
> 	+nec->I
>
> The whole struct I'm trying to refactor is below, you'll notice there are
> lots of different typedefs that are all being moved into the nec_t
> structure, but hopefully the description above explains what I'm trying to
> do.  The global variable names like "data" are always named the same,
> hence "identifier I={data}".  I just want to make sure that the
> replacement enforces the following:
>    1. "data" is a global variable and it is named "data"
>    2. "data" is of type "data_t"
>
> The xnec2c code I am refactoring is very sensitive to the difference
> between a "complex double" and a "double" since complex numbers and real
> numbers can be multipled in C without error or compiler warnings.
>
> There are type collisions between local and global variables (I know, bad
> form, but thats how it is) so I need to make sure only the same data types
> are replaced even if the names collide between local/global identififers.
>
> If the wrong local variable of type "double" was replaced with a global
> variable of type "complex double" or vice-versa, then the calculations
> would be wrong and it would be very difficult (or impossible) to figure
> out why.
>
> Most of the identifiers like "near_field" are pretty unique and could be a
> simple search-replace with nec->near_field, but others like "data", "cm",
> and "cmag" might be used with different types so I hope Coccinelle can
> enforce replacement of the variable type.
>
> Thanks for your help!
>
> -Eric
>
> More detail if you're curious:
>
> The actual new nec_t structure looks like this; all of these fields are new and the code needs to replace
> all occurances of each field with nec->field:
>
> 	typedef struct
> 	{
> 		// rad_pattern_t *rad_pattern; // pointer to the index into rad_pattern[freq_step]
>
> 		// Near E/H field data
> 		near_field_t near_field;
>
> 		complex double *cm;
>
> 		// Needed data
> 		impedance_data_t impedance_data;
>
> 		// Data for various calculations
> 		calc_data_t calc_data;
>
> 		// Magnitude of seg/patch current/charge
> 		double *cmag, *ct1m, *ct2m;
>
> 		crnt_t crnt;
>
> 		dataj_t dataj;
>
> 		data_t data;
>
> 		fpat_t fpat;
>
> 		ggrid_t ggrid;
>
> 		gnd_t gnd;
>
> 		gwav_t gwav;
>
> 		incom_t incom;
>
> 		matpar_t matpar;
>
> 		netcx_t netcx;
>
> 		save_t save;
>
> 		segj_t segj;
>
> 		smat_t smat;
>
> 		vsorc_t vsorc;
>
> 		zload_t zload;
> 	} nec_t;
>
>
