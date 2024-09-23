Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA89CF9C6F
	for <cocci@archiver.kernel.org>; Mon, 23 Sep 2024 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eCqZtdhlcRZ8xLnf2ph2giJflGfOVbFtfE5ydremUs4=;
  b=HEJXXDF7350TLozIhBE2ID1s336rkq9dWKsuEJqZOxcvu470Bi0tveMD
   BEaUATZrRIEh48zCqBfcGA6EFZTgPyJCHF2HL+JU9RSGnCacrLu9Afu60
   GxQBBTRhACL16ZqG+GmTjrYhYXGxI0ZAYBrXE/HlbB7XVnazJQCiqT3Lp
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="184550496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2024 12:24:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD963E013D; Mon, 23 Sep 2024 12:24:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F45EE00B7
	for <cocci@sympa.inria.fr>; Mon, 23 Sep 2024 12:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=eCqZtdhlcRZ8xLnf2ph2giJflGfOVbFtfE5ydremUs4=;
  b=pd1fP9iOxBlcKQKGmugnh1XeebHfaG8FvGASPSyrMbnjEKy6uWSDfeRm
   BsDb+hFydqmGbyKeUflhz0o6mGUJAx6lGxXV3WXmwwDIrQRUFZNoC38h5
   LyhzWyqQ5PVjADVxgUD0Q1FdTS+kTd2S6t26vpC8CtawNiVXKaPjXsIK/
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="184550478"
Received: from 56.66.136.77.rev.sfr.net (HELO smtpclient.apple) ([77.136.66.56])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 12:24:15 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 23 Sep 2024 12:24:04 +0200
Message-Id: <466D6A21-0E18-4FC3-9A92-6B3EA58C273D@inria.fr>
References: <952c42aa-001f-42f0-8ec5-eb7e592b2629@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr,
 linux-hardening@vger.kernel.org, cocci@inria.fr
In-Reply-To: <952c42aa-001f-42f0-8ec5-eb7e592b2629@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
X-Mailer: iPhone Mail (21E236)
Subject: Re: [cocci] [PATCH -next v3 01/10] coccinelle: Add rules to find
 str_true_false() replacements
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1886
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/466D6A21-0E18-4FC3-9A92-6B3EA58C273D%40inria.fr>

Thanks for testing it. I will see if there is some other way to improve the p=
erformance.
Sent from my iPhone

> On 23 Sep 2024, at 09:01, Hongbo Li <lihongbo22@huawei.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2024/9/19 14:25, Julia Lawall wrote:
>>> On Wed, 11 Sep 2024, Hongbo Li wrote:
>>> After str_true_false() has been introduced in the tree,
>>> we can add rules for finding places where str_true_false()
>>> can be used. A simple test can find over 10 locations.
>>>=20
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>  scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>=20
>>> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/cocci=
nelle/api/string_choices.cocci
>>> index 5e729f187f22..6942ad7c4224 100644
>>> --- a/scripts/coccinelle/api/string_choices.cocci
>>> +++ b/scripts/coccinelle/api/string_choices.cocci
>>> @@ -85,3 +85,22 @@ e << str_down_up_r.E;
>>>  @@
>>>=20
>>>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e=
)
>>> +
>>> +@str_true_false depends on patch@
>>> +expression E;
>>> +@@
>>> +-      ((E) ? "true" : "false")
>>> ++      str_true_false(E)
>>> +
>>> +@str_true_false_r depends on !patch exists@
>>> +expression E;
>>> +position P;
>>> +@@
>>> +*      ((E@P) ? "true" : "false")
>> Hello,
>> The semantic patch is quite slow.  Actually it tests a large number of
>> cases, eg where the parentheses are present and where they are not.
>> A small optimization is possible in the non-patch case.  The outer
>> parentheses are not needed, because you will already get the same
>> information whether they are there or not.
>> In contrast, for the patch case, the outer parentheses are needed, becaus=
e
>> if they are there we want to remove them, since they are not needed for
>> the function call.
>> Could you update the depends on !patch cases to remove the outer
>> parentheses?
>=20
> You mean in non-patch case, we could just write like the following?:
>=20
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +*      (E@P) ? "true" : "false"
>=20
> I have tested in my machine. The impact of this parenthesis on performance=
 is very minimal.
>=20
> With parentheses, the time on driver/ costs:
>=20
> real    1m41.696s
> user    85m24.069s
> sys    1m8.891s
>=20
> Without parentheses, the time on driver/ costs:
>=20
> real    1m40.438s
> user    85m53.987s
> sys    1m7.981s
>=20
>=20
> Thanks,
> Hongbo
>=20
>> Also, just one patch would be fine.  There are many changes, but they are=

>> all sort of the same, so it would be easier just to see them all at once.=

>> thanks,
>> julia
>>> +
>>> +@script:python depends on report@
>>> +p << str_true_false_r.P;
>>> +e << str_true_false_r.E;
>>> +@@
>>> +
>>> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)"=
 % e)
>>> --
>>> 2.34.1
>>>=20
>>>=20

