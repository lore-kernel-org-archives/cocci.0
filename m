Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEDC433EF
	for <cocci@archiver.kernel.org>; Tue, 10 May 2022 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QsFrDlNS/QqdyuPOzldgxE8urrk5AOZWucoRXlunGcI=;
  b=dZaIl+ECYyiwPklTTZFdzQ6Tnc0QNgzqd2DqYJKohmo7hCb70kj1Bz9s
   XHdkE1cZ9D3gnKSnRrgqVsWZVMDoGDXOubONVaniJkPGnjxhD8IShSejh
   u2k30VcmyE736Tzk5hftDAInStMMEFyf3ErEA9einSY+au4/Xf6s6+YRS
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35544933"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2022 12:39:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1595E027B; Tue, 10 May 2022 12:39:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 80D0EE0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 12:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QsFrDlNS/QqdyuPOzldgxE8urrk5AOZWucoRXlunGcI=;
  b=Vuvea1Zb1cecfYNxEAAtAKsCjgE2cbX4kmkE1soQyzJ827gJaE6oHsjp
   HKYUqQK62xZPih2TVNpQyjy7FTAqt8V9T2FSyYiDvX3YJ/t8+wX1aeJs3
   ZXdpRpbNwYzHKjqtSx66kvpgqhhaxHusZNiKLlCpwoKCmINnvP/ZkO/Ab
   o=;
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="13673427"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 12:39:06 +0200
Date: Tue, 10 May 2022 12:39:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com> <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 376
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205101236050.2667%40hadrien>

Here is a suggested solution for all of the problems reported so far:

@r@
type T;
identifier i;
expression E;
position p : script:python(i) { p[0].current_element == i };
attribute name __randomize_layout;
@@

(
T i(...);
|
T i(...,......);
|
extern T i;
|
T i@p;
|
T i@p=E;
)

@script:python@
i << r.i;
p << r.p;
@@
print (i)

----------------------

The problem with __randomize_layout is that the Coccinelle parser is not
recognizing it as an attribute.  You can force that by putting a
declaration in the semantic patch.

It seems that ... in a function parameter list does not match the ... in C
for a variable list of arguments.  That ... can be matched explicitly by
...... so I have added another case with that.

I als combined all of the patterns into one rule.  By inheriting the
position varaible p into the python rule at the end, that python rule is
only executed if p is defined, which makes it select the cases of interest
and ignore the others.

julia
