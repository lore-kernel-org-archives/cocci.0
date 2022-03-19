Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E2FC433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HtrOei8qKw2VoxpDUFNa8N6qsNiY0zA82US5K6mMkoA=;
  b=TO+GmE3IN+GCE2gNZVy+mwhO7vmt5mI6vhUGkgbUBpD3ICTqMa98JHNf
   na1GrszTuzILl91U84D+6tcqshD4PUSI6FAwwAEZhLPRYh5A4cr+PhJ+I
   ZNxFIt/K7NdBjgA5yrcAbO4deP7tSoQoqFjfeiwiTGcpz7B3PsT9RQMbk
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26984323"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 09:45:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ADFFDE031E; Sat, 19 Mar 2022 09:45:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 42394E031E
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 09:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HtrOei8qKw2VoxpDUFNa8N6qsNiY0zA82US5K6mMkoA=;
  b=XYJH23aUGbRQik3h1meF5wYBpXeNTV3iZTv77bYVorQ9L4r6ArYeGvkc
   DYR2LTMZDMLTJ1HTSZhPH6q+U7lf38yezum11YnkUDsutyl5Z0Z/wAXYi
   0oRD7r9J1EipR3Xe0Qm3qTHIyZL6pAk9bgoVFhHzNb49D2rcD5+clKkzD
   E=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9012282"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:45:45 +0100
Date: Sat, 19 Mar 2022 09:45:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203190945040.3204@hadrien>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net> <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net> <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 237
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203190945040.3204%40hadrien>



On Fri, 18 Mar 2022, Eric Wheeler wrote:

> On Fri, 18 Mar 2022, Eric Wheeler wrote:
> > On Fri, 18 Mar 2022, Eric Wheeler wrote:
> > > I have a bunch of structs with lots of members.  I need a way to compare
> > > to instances of those structs to see if they have changed.  The easiest
> > > way to do that is compare `if (a.j != b.j) { match() }` but it would be
> > > lots of tedious hand-typing all those if's, or doing a bunch of ugly greps
> > > and cuts on the .c files to hand-parse what I want.
>
> I am continuously amazed by what Coccinelle is capable of.

That looks really nice.  I'm not sure if anyone has considered this use
case previously :)

julia


>
> We are working to make the xnec2c EM simulator thread safe
> (www.xnec2c.org) but we need to figure out what is being modified between
> frequency loops to isolate the data.  Check this out:
>
> 	spatch --sp-file cocci/nec-data-diff.cocci t.c src/common.h src/shared.c
>
> src/common.h and src/shared.c are in the xnec2c codebase if you're curious:
> 	https://github.com/KJ7LNW/xnec2c/tree/master/src
>
> This is t.c where I'm staging the comparisons:
> 	typedef struct
> 	{
> 		int x, y, z;
> 		int u, v;
> 		int w;
> 	} A;
>
> 	A a, b;
>
> 	#define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
> 	f()
> 	{
> 	}
>
> Here is the SmPL:
> 	// Match these struct types:
> 	@ r1 @
> 	typedef cm_t, cmag_t, crnt_t, ct1m_t, ct2m_t, data_t, dataj_t, fpat_t,
> 	    ggrid_t, gnd_t, gwav_t, impedance_data_t, incom_t, matpar_t, near_field_t,
> 	    netcx_t, save_t, segj_t, smat_t, zload_t, vsorc_t;
> 	type T = {cm_t, cmag_t, crnt_t, ct1m_t, ct2m_t, data_t, dataj_t, fpat_t,
> 	    ggrid_t, gnd_t, gwav_t, impedance_data_t, incom_t, matpar_t, near_field_t,
> 	    netcx_t, save_t, segj_t, smat_t, zload_t, vsorc_t};
> 	type FT;
> 	identifier F;
> 	@@
>
> 	typedef struct
> 	{
> 	    ...
> 	    FT F;
> 	    ...
> 	} T;
>
>
> 	// Match the variable definition:
> 	@ struct_name @
> 	type r1.T;
> 	identifier I;
> 	@@
> 	T I;
>
> 	// Add the compare_T() function call and compare_T function definition for each type:
> 	@ r2 @
> 	identifier struct_name.I;
> 	fresh identifier FN = "compare_"##I;
> 	@@
> 	f()
> 	{
> 	++  FN();
> 	}
> 	++void FN(){}
>
>
> 	// Add the comparisons for each type member:
> 	@ r3 @
> 	identifier r2.FN;
> 	type r1.T;
> 	identifier r1.F;
> 	@@
> 	void FN()
> 	{
> 	    ...
> 	++  if (a.F != b.F) NOMATCH(a, b, T, F);
> 	}
>
> And here is the output that probably saved hours of time.
>
> Kudos to the Coccinelle team!
>
>
> [root@el7-dev xnec2c-git]# spatch --sp-file cocci/nec-data-diff.cocci t.c src/common.h src/shared.c
> init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
> HANDLING: t.c src/common.h src/shared.c
> diff =
> --- t.c
> +++ /tmp/cocci-output-26246-5722fe-t.c
> @@ -10,6 +10,579 @@ A a, b;
>  #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
>  f()
>  {
> +	compare_impedance_data();
> +	compare_gwav();
> +	compare_smat();
> +	compare_zload();
> +	compare_incom();
> +	compare_netcx();
> +	compare_vsorc();
> +	compare_matpar();
> +	compare_fpat();
> +	compare_gnd();
> +	compare_save();
> +	compare_data();
> +	compare_dataj();
> +	compare_segj();
> +	compare_ggrid();
> +	compare_near_field();
> +	compare_crnt();
> +}
> +
> +void compare_impedance_data()
> +{
> +	if (a.zreal != b.zreal)
> +		NOMATCH(a, b, impedance_data_t, zreal);
> +	if (a.zphase != b.zphase)
> +		NOMATCH(a, b, impedance_data_t, zphase);
> +	if (a.zmagn != b.zmagn)
> +		NOMATCH(a, b, impedance_data_t, zmagn);
> +	if (a.zimag != b.zimag)
> +		NOMATCH(a, b, impedance_data_t, zimag);
> +}
> +
> +void compare_gwav()
> +{
> +	if (a.zph != b.zph)
> +		NOMATCH(a, b, gwav_t, zph);
> +	if (a.zmh != b.zmh)
> +		NOMATCH(a, b, gwav_t, zmh);
> +	if (a.xx2 != b.xx2)
> +		NOMATCH(a, b, gwav_t, xx2);
> +	if (a.xx1 != b.xx1)
> +		NOMATCH(a, b, gwav_t, xx1);
> +	if (a.u2 != b.u2)
> +		NOMATCH(a, b, gwav_t, u2);
> +	if (a.u != b.u)
> +		NOMATCH(a, b, gwav_t, u);
> +	if (a.r2 != b.r2)
> +		NOMATCH(a, b, gwav_t, r2);
> +	if (a.r1 != b.r1)
> +		NOMATCH(a, b, gwav_t, r1);
> +}
> +
> +void compare_smat()
> +{
> +	if (a.ssx != b.ssx)
> +		NOMATCH(a, b, smat_t, ssx);
> +	if (a.nop != b.nop)
> +		NOMATCH(a, b, smat_t, nop);
> +}
> +
> +void compare_zload()
> +{
> +	if (a.zarray != b.zarray)
> +		NOMATCH(a, b, zload_t, zarray);
> +	if (a.nload != b.nload)
> +		NOMATCH(a, b, zload_t, nload);
> +	if (a.nldseg != b.nldseg)
> +		NOMATCH(a, b, zload_t, nldseg);
> +	if (a.ldtype != b.ldtype)
> +		NOMATCH(a, b, zload_t, ldtype);
> +	if (a.ldsegn != b.ldsegn)
> +		NOMATCH(a, b, zload_t, ldsegn);
> +}
> +
> +void compare_incom()
> +{
> +	if (a.zo != b.zo)
> +		NOMATCH(a, b, incom_t, zo);
> +	if (a.ysn != b.ysn)
> +		NOMATCH(a, b, incom_t, ysn);
> +	if (a.yo != b.yo)
> +		NOMATCH(a, b, incom_t, yo);
> +	if (a.xsn != b.xsn)
> +		NOMATCH(a, b, incom_t, xsn);
> +	if (a.xo != b.xo)
> +		NOMATCH(a, b, incom_t, xo);
> +	if (a.sn != b.sn)
> +		NOMATCH(a, b, incom_t, sn);
> +	if (a.isnor != b.isnor)
> +		NOMATCH(a, b, incom_t, isnor);
> +}
> +
> +void compare_netcx()
> +{
> +	if (a.zped != b.zped)
> +		NOMATCH(a, b, netcx_t, zped);
> +	if (a.x22r != b.x22r)
> +		NOMATCH(a, b, netcx_t, x22r);
> +	if (a.x22i != b.x22i)
> +		NOMATCH(a, b, netcx_t, x22i);
> +	if (a.x12r != b.x12r)
> +		NOMATCH(a, b, netcx_t, x12r);
> +	if (a.x12i != b.x12i)
> +		NOMATCH(a, b, netcx_t, x12i);
> +	if (a.x11r != b.x11r)
> +		NOMATCH(a, b, netcx_t, x11r);
> +	if (a.x11i != b.x11i)
> +		NOMATCH(a, b, netcx_t, x11i);
> +	if (a.pnls != b.pnls)
> +		NOMATCH(a, b, netcx_t, pnls);
> +	if (a.pin != b.pin)
> +		NOMATCH(a, b, netcx_t, pin);
> +	if (a.ntyp != b.ntyp)
> +		NOMATCH(a, b, netcx_t, ntyp);
> +	if (a.ntsol != b.ntsol)
> +		NOMATCH(a, b, netcx_t, ntsol);
> +	if (a.nprint != b.nprint)
> +		NOMATCH(a, b, netcx_t, nprint);
> +	if (a.npeq != b.npeq)
> +		NOMATCH(a, b, netcx_t, npeq);
> +	if (a.nonet != b.nonet)
> +		NOMATCH(a, b, netcx_t, nonet);
> +	if (a.neq2 != b.neq2)
> +		NOMATCH(a, b, netcx_t, neq2);
> +	if (a.neq != b.neq)
> +		NOMATCH(a, b, netcx_t, neq);
> +	if (a.masym != b.masym)
> +		NOMATCH(a, b, netcx_t, masym);
> +	if (a.iseg2 != b.iseg2)
> +		NOMATCH(a, b, netcx_t, iseg2);
> +	if (a.iseg1 != b.iseg1)
> +		NOMATCH(a, b, netcx_t, iseg1);
> +}
> +
> +void compare_vsorc()
> +{
> +	if (a.vsant != b.vsant)
> +		NOMATCH(a, b, vsorc_t, vsant);
> +	if (a.vqds != b.vqds)
> +		NOMATCH(a, b, vsorc_t, vqds);
> +	if (a.vqd != b.vqd)
> +		NOMATCH(a, b, vsorc_t, vqd);
> +	if (a.nvqd != b.nvqd)
> +		NOMATCH(a, b, vsorc_t, nvqd);
> +	if (a.nsant != b.nsant)
> +		NOMATCH(a, b, vsorc_t, nsant);
> +	if (a.nqds != b.nqds)
> +		NOMATCH(a, b, vsorc_t, nqds);
> +	if (a.ivqd != b.ivqd)
> +		NOMATCH(a, b, vsorc_t, ivqd);
> +	if (a.isant != b.isant)
> +		NOMATCH(a, b, vsorc_t, isant);
> +	if (a.iqds != b.iqds)
> +		NOMATCH(a, b, vsorc_t, iqds);
> +}
> +
> +void compare_matpar()
> +{
> +	if (a.npblk != b.npblk)
> +		NOMATCH(a, b, matpar_t, npblk);
> +	if (a.nlast != b.nlast)
> +		NOMATCH(a, b, matpar_t, nlast);
> +	if (a.imat != b.imat)
> +		NOMATCH(a, b, matpar_t, imat);
> +	if (a.icase != b.icase)
> +		NOMATCH(a, b, matpar_t, icase);
> +}
> +
> +void compare_fpat()
> +{
> +	if (a.znr != b.znr)
> +		NOMATCH(a, b, fpat_t, znr);
> +	if (a.ynr != b.ynr)
> +		NOMATCH(a, b, fpat_t, ynr);
> +	if (a.xnr != b.xnr)
> +		NOMATCH(a, b, fpat_t, xnr);
> +	if (a.thets != b.thets)
> +		NOMATCH(a, b, fpat_t, thets);
> +	if (a.sig2 != b.sig2)
> +		NOMATCH(a, b, fpat_t, sig2);
> +	if (a.rfld != b.rfld)
> +		NOMATCH(a, b, fpat_t, rfld);
> +	if (a.pnlr != b.pnlr)
> +		NOMATCH(a, b, fpat_t, pnlr);
> +	if (a.ploss != b.ploss)
> +		NOMATCH(a, b, fpat_t, ploss);
> +	if (a.pinr != b.pinr)
> +		NOMATCH(a, b, fpat_t, pinr);
> +	if (a.phis != b.phis)
> +		NOMATCH(a, b, fpat_t, phis);
> +	if (a.nth != b.nth)
> +		NOMATCH(a, b, fpat_t, nth);
> +	if (a.nrz != b.nrz)
> +		NOMATCH(a, b, fpat_t, nrz);
> +	if (a.nry != b.nry)
> +		NOMATCH(a, b, fpat_t, nry);
> +	if (a.nrx != b.nrx)
> +		NOMATCH(a, b, fpat_t, nrx);
> +	if (a.nph != b.nph)
> +		NOMATCH(a, b, fpat_t, nph);
> +	if (a.nfeh != b.nfeh)
> +		NOMATCH(a, b, fpat_t, nfeh);
> +	if (a.near != b.near)
> +		NOMATCH(a, b, fpat_t, near);
> +	if (a.ixtyp != b.ixtyp)
> +		NOMATCH(a, b, fpat_t, ixtyp);
> +	if (a.ipd != b.ipd)
> +		NOMATCH(a, b, fpat_t, ipd);
> +	if (a.inor != b.inor)
> +		NOMATCH(a, b, fpat_t, inor);
> +	if (a.iax != b.iax)
> +		NOMATCH(a, b, fpat_t, iax);
> +	if (a.iavp != b.iavp)
> +		NOMATCH(a, b, fpat_t, iavp);
> +	if (a.gnor != b.gnor)
> +		NOMATCH(a, b, fpat_t, gnor);
> +	if (a.epsr2 != b.epsr2)
> +		NOMATCH(a, b, fpat_t, epsr2);
> +	if (a.dznr != b.dznr)
> +		NOMATCH(a, b, fpat_t, dznr);
> +	if (a.dynr != b.dynr)
> +		NOMATCH(a, b, fpat_t, dynr);
> +	if (a.dxnr != b.dxnr)
> +		NOMATCH(a, b, fpat_t, dxnr);
> +	if (a.dth != b.dth)
> +		NOMATCH(a, b, fpat_t, dth);
> +	if (a.dph != b.dph)
> +		NOMATCH(a, b, fpat_t, dph);
> +	if (a.clt != b.clt)
> +		NOMATCH(a, b, fpat_t, clt);
> +	if (a.cht != b.cht)
> +		NOMATCH(a, b, fpat_t, cht);
> +}
> +
> +void compare_gnd()
> +{
> +	if (a.zrati2 != b.zrati2)
> +		NOMATCH(a, b, gnd_t, zrati2);
> +	if (a.zrati != b.zrati)
> +		NOMATCH(a, b, gnd_t, zrati);
> +	if (a.t2 != b.t2)
> +		NOMATCH(a, b, gnd_t, t2);
> +	if (a.t1 != b.t1)
> +		NOMATCH(a, b, gnd_t, t1);
> +	if (a.scrwr != b.scrwr)
> +		NOMATCH(a, b, gnd_t, scrwr);
> +	if (a.scrwl != b.scrwl)
> +		NOMATCH(a, b, gnd_t, scrwl);
> +	if (a.nradl != b.nradl)
> +		NOMATCH(a, b, gnd_t, nradl);
> +	if (a.ksymp != b.ksymp)
> +		NOMATCH(a, b, gnd_t, ksymp);
> +	if (a.iperf != b.iperf)
> +		NOMATCH(a, b, gnd_t, iperf);
> +	if (a.ifar != b.ifar)
> +		NOMATCH(a, b, gnd_t, ifar);
> +	if (a.gpflag != b.gpflag)
> +		NOMATCH(a, b, gnd_t, gpflag);
> +	if (a.frati != b.frati)
> +		NOMATCH(a, b, gnd_t, frati);
> +	if (a.cl != b.cl)
> +		NOMATCH(a, b, gnd_t, cl);
> +	if (a.ch != b.ch)
> +		NOMATCH(a, b, gnd_t, ch);
> +}
> +
> +void compare_save()
> +{
> +	if (a.ztemp != b.ztemp)
> +		NOMATCH(a, b, save_t, ztemp);
> +	if (a.ytemp != b.ytemp)
> +		NOMATCH(a, b, save_t, ytemp);
> +	if (a.xtemp != b.xtemp)
> +		NOMATCH(a, b, save_t, xtemp);
> +	if (a.sitemp != b.sitemp)
> +		NOMATCH(a, b, save_t, sitemp);
> +	if (a.sig != b.sig)
> +		NOMATCH(a, b, save_t, sig);
> +	if (a.scrwrt != b.scrwrt)
> +		NOMATCH(a, b, save_t, scrwrt);
> +	if (a.scrwlt != b.scrwlt)
> +		NOMATCH(a, b, save_t, scrwlt);
> +	if (a.last_freq != b.last_freq)
> +		NOMATCH(a, b, save_t, last_freq);
> +	if (a.ip != b.ip)
> +		NOMATCH(a, b, save_t, ip);
> +	if (a.fstep != b.fstep)
> +		NOMATCH(a, b, save_t, fstep);
> +	if (a.freq != b.freq)
> +		NOMATCH(a, b, save_t, freq);
> +	if (a.fmhz != b.fmhz)
> +		NOMATCH(a, b, save_t, fmhz);
> +	if (a.epsr != b.epsr)
> +		NOMATCH(a, b, save_t, epsr);
> +	if (a.bitemp != b.bitemp)
> +		NOMATCH(a, b, save_t, bitemp);
> +}
> +
> +void compare_data()
> +{
> +	if (a.z2 != b.z2)
> +		NOMATCH(a, b, data_t, z2);
> +	if (a.z1 != b.z1)
> +		NOMATCH(a, b, data_t, z1);
> +	if (a.z != b.z)
> +		NOMATCH(a, b, data_t, z);
> +	if (a.y2 != b.y2)
> +		NOMATCH(a, b, data_t, y2);
> +	if (a.y1 != b.y1)
> +		NOMATCH(a, b, data_t, y1);
> +	if (a.y != b.y)
> +		NOMATCH(a, b, data_t, y);
> +	if (a.x2 != b.x2)
> +		NOMATCH(a, b, data_t, x2);
> +	if (a.x1 != b.x1)
> +		NOMATCH(a, b, data_t, x1);
> +	if (a.x != b.x)
> +		NOMATCH(a, b, data_t, x);
> +	if (a.wlam != b.wlam)
> +		NOMATCH(a, b, data_t, wlam);
> +	if (a.t2z != b.t2z)
> +		NOMATCH(a, b, data_t, t2z);
> +	if (a.t2y != b.t2y)
> +		NOMATCH(a, b, data_t, t2y);
> +	if (a.t2x != b.t2x)
> +		NOMATCH(a, b, data_t, t2x);
> +	if (a.t1z != b.t1z)
> +		NOMATCH(a, b, data_t, t1z);
> +	if (a.t1y != b.t1y)
> +		NOMATCH(a, b, data_t, t1y);
> +	if (a.t1x != b.t1x)
> +		NOMATCH(a, b, data_t, t1x);
> +	if (a.si != b.si)
> +		NOMATCH(a, b, data_t, si);
> +	if (a.salp != b.salp)
> +		NOMATCH(a, b, data_t, salp);
> +	if (a.sab != b.sab)
> +		NOMATCH(a, b, data_t, sab);
> +	if (a.pz2 != b.pz2)
> +		NOMATCH(a, b, data_t, pz2);
> +	if (a.pz1 != b.pz1)
> +		NOMATCH(a, b, data_t, pz1);
> +	if (a.pz != b.pz)
> +		NOMATCH(a, b, data_t, pz);
> +	if (a.py2 != b.py2)
> +		NOMATCH(a, b, data_t, py2);
> +	if (a.py1 != b.py1)
> +		NOMATCH(a, b, data_t, py1);
> +	if (a.py != b.py)
> +		NOMATCH(a, b, data_t, py);
> +	if (a.px2 != b.px2)
> +		NOMATCH(a, b, data_t, px2);
> +	if (a.px1 != b.px1)
> +		NOMATCH(a, b, data_t, px1);
> +	if (a.px != b.px)
> +		NOMATCH(a, b, data_t, px);
> +	if (a.psalp != b.psalp)
> +		NOMATCH(a, b, data_t, psalp);
> +	if (a.pbi != b.pbi)
> +		NOMATCH(a, b, data_t, pbi);
> +	if (a.npm != b.npm)
> +		NOMATCH(a, b, data_t, npm);
> +	if (a.np3m != b.np3m)
> +		NOMATCH(a, b, data_t, np3m);
> +	if (a.np2m != b.np2m)
> +		NOMATCH(a, b, data_t, np2m);
> +	if (a.np != b.np)
> +		NOMATCH(a, b, data_t, np);
> +	if (a.n != b.n)
> +		NOMATCH(a, b, data_t, n);
> +	if (a.mp != b.mp)
> +		NOMATCH(a, b, data_t, mp);
> +	if (a.m != b.m)
> +		NOMATCH(a, b, data_t, m);
> +	if (a.itag != b.itag)
> +		NOMATCH(a, b, data_t, itag);
> +	if (a.ipsym != b.ipsym)
> +		NOMATCH(a, b, data_t, ipsym);
> +	if (a.icon2 != b.icon2)
> +		NOMATCH(a, b, data_t, icon2);
> +	if (a.icon1 != b.icon1)
> +		NOMATCH(a, b, data_t, icon1);
> +	if (a.cab != b.cab)
> +		NOMATCH(a, b, data_t, cab);
> +	if (a.bi != b.bi)
> +		NOMATCH(a, b, data_t, bi);
> +}
> +
> +void compare_dataj()
> +{
> +	if (a.zj != b.zj)
> +		NOMATCH(a, b, dataj_t, zj);
> +	if (a.yj != b.yj)
> +		NOMATCH(a, b, dataj_t, yj);
> +	if (a.xj != b.xj)
> +		NOMATCH(a, b, dataj_t, xj);
> +	if (a.t2zj != b.t2zj)
> +		NOMATCH(a, b, dataj_t, t2zj);
> +	if (a.t2yj != b.t2yj)
> +		NOMATCH(a, b, dataj_t, t2yj);
> +	if (a.t2xj != b.t2xj)
> +		NOMATCH(a, b, dataj_t, t2xj);
> +	if (a.t1zj != b.t1zj)
> +		NOMATCH(a, b, dataj_t, t1zj);
> +	if (a.t1yj != b.t1yj)
> +		NOMATCH(a, b, dataj_t, t1yj);
> +	if (a.t1xj != b.t1xj)
> +		NOMATCH(a, b, dataj_t, t1xj);
> +	if (a.salpj != b.salpj)
> +		NOMATCH(a, b, dataj_t, salpj);
> +	if (a.sabj != b.sabj)
> +		NOMATCH(a, b, dataj_t, sabj);
> +	if (a.s != b.s)
> +		NOMATCH(a, b, dataj_t, s);
> +	if (a.rkh != b.rkh)
> +		NOMATCH(a, b, dataj_t, rkh);
> +	if (a.ipgnd != b.ipgnd)
> +		NOMATCH(a, b, dataj_t, ipgnd);
> +	if (a.indd2 != b.indd2)
> +		NOMATCH(a, b, dataj_t, indd2);
> +	if (a.indd1 != b.indd1)
> +		NOMATCH(a, b, dataj_t, indd1);
> +	if (a.ind2 != b.ind2)
> +		NOMATCH(a, b, dataj_t, ind2);
> +	if (a.ind1 != b.ind1)
> +		NOMATCH(a, b, dataj_t, ind1);
> +	if (a.iexk != b.iexk)
> +		NOMATCH(a, b, dataj_t, iexk);
> +	if (a.ezs != b.ezs)
> +		NOMATCH(a, b, dataj_t, ezs);
> +	if (a.ezk != b.ezk)
> +		NOMATCH(a, b, dataj_t, ezk);
> +	if (a.ezc != b.ezc)
> +		NOMATCH(a, b, dataj_t, ezc);
> +	if (a.eys != b.eys)
> +		NOMATCH(a, b, dataj_t, eys);
> +	if (a.eyk != b.eyk)
> +		NOMATCH(a, b, dataj_t, eyk);
> +	if (a.eyc != b.eyc)
> +		NOMATCH(a, b, dataj_t, eyc);
> +	if (a.exs != b.exs)
> +		NOMATCH(a, b, dataj_t, exs);
> +	if (a.exk != b.exk)
> +		NOMATCH(a, b, dataj_t, exk);
> +	if (a.exc != b.exc)
> +		NOMATCH(a, b, dataj_t, exc);
> +	if (a.cabj != b.cabj)
> +		NOMATCH(a, b, dataj_t, cabj);
> +	if (a.b != b.b)
> +		NOMATCH(a, b, dataj_t, b);
> +}
> +
> +void compare_segj()
> +{
> +	if (a.maxcon != b.maxcon)
> +		NOMATCH(a, b, segj_t, maxcon);
> +	if (a.jsno != b.jsno)
> +		NOMATCH(a, b, segj_t, jsno);
> +	if (a.jco != b.jco)
> +		NOMATCH(a, b, segj_t, jco);
> +	if (a.cx != b.cx)
> +		NOMATCH(a, b, segj_t, cx);
> +	if (a.bx != b.bx)
> +		NOMATCH(a, b, segj_t, bx);
> +	if (a.ax != b.ax)
> +		NOMATCH(a, b, segj_t, ax);
> +}
> +
> +void compare_ggrid()
> +{
> +	if (a.ysa != b.ysa)
> +		NOMATCH(a, b, ggrid_t, ysa);
> +	if (a.xsa != b.xsa)
> +		NOMATCH(a, b, ggrid_t, xsa);
> +	if (a.nya != b.nya)
> +		NOMATCH(a, b, ggrid_t, nya);
> +	if (a.nxa != b.nxa)
> +		NOMATCH(a, b, ggrid_t, nxa);
> +	if (a.epscf != b.epscf)
> +		NOMATCH(a, b, ggrid_t, epscf);
> +	if (a.dya != b.dya)
> +		NOMATCH(a, b, ggrid_t, dya);
> +	if (a.dxa != b.dxa)
> +		NOMATCH(a, b, ggrid_t, dxa);
> +	if (a.ar3 != b.ar3)
> +		NOMATCH(a, b, ggrid_t, ar3);
> +	if (a.ar2 != b.ar2)
> +		NOMATCH(a, b, ggrid_t, ar2);
> +	if (a.ar1 != b.ar1)
> +		NOMATCH(a, b, ggrid_t, ar1);
> +}
> +
> +void compare_near_field()
> +{
> +	if (a.valid != b.valid)
> +		NOMATCH(a, b, near_field_t, valid);
> +	if (a.r_max != b.r_max)
> +		NOMATCH(a, b, near_field_t, r_max);
> +	if (a.pz != b.pz)
> +		NOMATCH(a, b, near_field_t, pz);
> +	if (a.py != b.py)
> +		NOMATCH(a, b, near_field_t, py);
> +	if (a.px != b.px)
> +		NOMATCH(a, b, near_field_t, px);
> +	if (a.newer != b.newer)
> +		NOMATCH(a, b, near_field_t, newer);
> +	if (a.max_hr != b.max_hr)
> +		NOMATCH(a, b, near_field_t, max_hr);
> +	if (a.max_er != b.max_er)
> +		NOMATCH(a, b, near_field_t, max_er);
> +	if (a.hz != b.hz)
> +		NOMATCH(a, b, near_field_t, hz);
> +	if (a.hy != b.hy)
> +		NOMATCH(a, b, near_field_t, hy);
> +	if (a.hx != b.hx)
> +		NOMATCH(a, b, near_field_t, hx);
> +	if (a.hrz != b.hrz)
> +		NOMATCH(a, b, near_field_t, hrz);
> +	if (a.hry != b.hry)
> +		NOMATCH(a, b, near_field_t, hry);
> +	if (a.hrx != b.hrx)
> +		NOMATCH(a, b, near_field_t, hrx);
> +	if (a.hr != b.hr)
> +		NOMATCH(a, b, near_field_t, hr);
> +	if (a.fhz != b.fhz)
> +		NOMATCH(a, b, near_field_t, fhz);
> +	if (a.fhy != b.fhy)
> +		NOMATCH(a, b, near_field_t, fhy);
> +	if (a.fhx != b.fhx)
> +		NOMATCH(a, b, near_field_t, fhx);
> +	if (a.fez != b.fez)
> +		NOMATCH(a, b, near_field_t, fez);
> +	if (a.fey != b.fey)
> +		NOMATCH(a, b, near_field_t, fey);
> +	if (a.fex != b.fex)
> +		NOMATCH(a, b, near_field_t, fex);
> +	if (a.ez != b.ez)
> +		NOMATCH(a, b, near_field_t, ez);
> +	if (a.ey != b.ey)
> +		NOMATCH(a, b, near_field_t, ey);
> +	if (a.ex != b.ex)
> +		NOMATCH(a, b, near_field_t, ex);
> +	if (a.erz != b.erz)
> +		NOMATCH(a, b, near_field_t, erz);
> +	if (a.ery != b.ery)
> +		NOMATCH(a, b, near_field_t, ery);
> +	if (a.erx != b.erx)
> +		NOMATCH(a, b, near_field_t, erx);
> +	if (a.er != b.er)
> +		NOMATCH(a, b, near_field_t, er);
> +	if (a.anim_step != b.anim_step)
> +		NOMATCH(a, b, near_field_t, anim_step);
> +}
> +
> +void compare_crnt()
> +{
> +	if (a.valid != b.valid)
> +		NOMATCH(a, b, crnt_t, valid);
> +	if (a.newer != b.newer)
> +		NOMATCH(a, b, crnt_t, newer);
> +	if (a.cur != b.cur)
> +		NOMATCH(a, b, crnt_t, cur);
> +	if (a.cir != b.cir)
> +		NOMATCH(a, b, crnt_t, cir);
> +	if (a.cii != b.cii)
> +		NOMATCH(a, b, crnt_t, cii);
> +	if (a.bir != b.bir)
> +		NOMATCH(a, b, crnt_t, bir);
> +	if (a.bii != b.bii)
> +		NOMATCH(a, b, crnt_t, bii);
> +	if (a.air != b.air)
> +		NOMATCH(a, b, crnt_t, air);
> +	if (a.aii != b.aii)
> +		NOMATCH(a, b, crnt_t, aii);
>  }
>
>
