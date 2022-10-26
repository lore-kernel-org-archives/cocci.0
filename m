Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568EBC433FE
	for <cocci@archiver.kernel.org>; Wed, 26 Oct 2022 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:in-reply-to:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DZP8yKgW4HjdKTkozolMvbnhJf5LI1Ul0uJHQfDY+L4=;
  b=PkSeQbofflNFCzKVKTrNlhdt2v/lP4evHAR7mEVQMi2VeKoNDajqg9wI
   STjgSUDBsVa3SIAXfhvHSMEa4x6PCs/j+nZcmFBKI62Oi+IUvJJLBWLgZ
   FuBOGpWXF1swtj/pE7Uo34oAKwMOshpwLYH26d+St/zgwVScnVM21pUKX
   s=;
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
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="71586243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2022 10:05:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 561D3E0307; Wed, 26 Oct 2022 10:05:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D6C8CE01CB
	for <cocci@sympa.inria.fr>; Wed, 26 Oct 2022 10:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DZP8yKgW4HjdKTkozolMvbnhJf5LI1Ul0uJHQfDY+L4=;
  b=pcVdLFhlo+Dg5vLoEFy+q0XcELdNcWGTiX4u4UI8rxSqsnOQSEbyr2kV
   D+qrPZxEjBfBezwDmDF+XKexM37PltynEQOwZFr0Ik3rNepls5TPC2kQ5
   Yrn37n75eK83zBRZR1LmVO2vETpMAFgoWlawOem6o8deJfl3g5tOuy4vM
   k=;
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="35585541"
Received: from 37-170-13-27.coucou-networks.fr (HELO pl347-pro) ([37.170.13.27])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 10:05:52 +0200
References: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
 <3ee3239d-4b72-9239-893e-b08acbae7df9@inria.fr>
 <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 29.0.50
From: Thierry Martinez <Thierry.Martinez@inria.fr>
To: Jan Tojnar <jtojnar@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-reply-to: <f0cc086369f9d48bf5ee47349d936335cac13005.camel@gmail.com>
Date: Wed, 26 Oct 2022 10:05:50 +0200
Message-ID: <ow4zgdj3t7l.fsf@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] No longer possible to build with system dependencies?
Reply-To: Thierry Martinez <Thierry.Martinez@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 691
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/ow4zgdj3t7l.fsf%40inria.fr>

Jan Tojnar=C2=A0:
> Apparently, three braces are sufficient to make it work but why that is
> the case eludes me. m4 language is simply beyond my comprehension.

Oops, you are correct: [[..]] is the proper way for quoting strings if we
want to preserve inner square brackets
(cf. https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Q=
uotation-and-Nested-Macros.html).

It will be fixed by the following merge request:
https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/231

Thanks!
--=20
Thierry.

Jan Tojnar=C2=A0:
> On Tue, 2022-10-25 at 16:54 +0200, Julia Lawall wrote:
>>=20
>> This problem should be fixed now.
>
> Thanks, d9ce82a556e313684af74912cf204bb902e04436 fixes the issue for
> stdcompat but it still does not work for pyml.
>
> If I remove the `/dev/null` redirection from pyml=E2=80=99s configure tes=
t, it
> reveals the following error:
>
>     File "configure_test.ml", line 2, characters 0-0:
>     Error: Syntax error
>
> Looking at the contents of `configure_test.ml`, the square braces do
> not appear to have been transferred:
>
>     Py.Class.init ~parents:
>
> Apparently, three braces are sufficient to make it work but why that is
> the case eludes me. m4 language is simply beyond my comprehension.

