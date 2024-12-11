Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36613E7717D
	for <cocci@archiver.kernel.org>; Wed, 11 Dec 2024 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LogfEsjzKOHOoGQxSHNTeMJxTG82UjsJCI9Cy41kMKA=;
  b=a3BY2fwyZur2NnVThKP1+zJElrJwKaWwKJ0x346VikEgnITSmbGsNjf0
   fdMIegUQvlaEccz3lz41HpHbZyzzaAZZTmIWTHEcxS+hWzjq686u8Vpsq
   XBDs8abPnSOPNJU9zf26h0OR0ntpRBA4+DVI0mLLYRjxBeg8W98HAX1XT
   o=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="198621066"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2024 14:21:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65F26E0D1D; Wed, 11 Dec 2024 14:21:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BB0F6E0077
	for <cocci@sympa.inria.fr>; Wed, 11 Dec 2024 14:20:59 +0100 (CET)
IronPort-SDR: 6759919f_oeWysRa3cgFaBUsFxWuW5hGUbrgYZaMNFboPssl9I/QAOmL
 bCZFH5F8QDyGeNKmU7bx58p0UEhaInS06ItXODg==
X-IPAS-Result: =?us-ascii?q?A0GaCgAukVlngAMP49RagQmEF2IhVDMEC0iEVo9NgXQwh?=
 =?us-ascii?q?DuHO4dWiHaDVA8BAwENQQECBAEBAwSCDIJ0AopqAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ9gjABAw4jB?=
 =?us-ascii?q?68/gTITboIMAQEG2lsfLCJXgWQJgRouhWuCSRoBcoU0hDwnD4FVRIE8C4JHM?=
 =?us-ascii?q?T6EQ4NbgmmCQIV5Z5xeUnscA1kyAVUTFwsHBYEpICwDLjcxggUcgT8FN0eCS?=
 =?us-ascii?q?WlJNwINAjaCJCRYgk2BJQQFg2uBC4NehFeGJIIZgQQdQAIBC209NwkLGwY9n?=
 =?us-ascii?q?FiCYzZHg2rGHjQHgjiBZYFjDJ9aBhMvl0MOBpJ6mHsiozKFVoF+I4FcMxokg?=
 =?us-ascii?q?zZPAxkPjlmDdb4iQjU8AgcLAQEDCYVGAQGKPoFLAQE?=
IronPort-PHdr: A9a23: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
 tWdzMobxx9d/tiS8cZOXqDp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3+oh66l/93MHN+t+oJGTQSPE+3rpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AU1S+nmpcoBL5GOfCZKyOk87mUZkJS3rX63PxGWC?=
 =?us-ascii?q?xLmtVT7qbcF6b+7wxxg=3D=3D?=
X-Talos-MUID: 9a23:4jqqlQaT8y/S1eBTrW7cwy9fFd1TxqWpLH9Rq6go69CVOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="104042460"
X-MGA-submission: =?us-ascii?q?MDEh0W5tiHqXR4Bihvm6G9OZe6p/qriTKI0HFP?=
 =?us-ascii?q?0rgjBPheNUKI2vVZSY2t5jSnOvqI+D+vJHcpUxMRpmnZy94BD5FAuL60?=
 =?us-ascii?q?TCeqrNqWUR+Wiq5dy9VBnOxFOf2g/Bc6ut1SacystBfxn6L4gflQ78Ft?=
 =?us-ascii?q?tikktnmiu52wgCXG03BlqRaQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:20:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733923230; x=1734528030; i=markus.elfring@web.de;
	bh=LogfEsjzKOHOoGQxSHNTeMJxTG82UjsJCI9Cy41kMKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QNos6V/Y93k9w2WaSFTPfJpRWj+rGvy2PupJUlZW5f4bsMTUrqgKIBPzQ/vgvvrY
	 6TJsR4rBzasmJHHJgW9a5VF09NJUfSr1qa27x0DRLb6da82Glq4nMptxTJS0/QsP4
	 /53u45sLh67GYtzzoym5P8ox2Xy/T0lOlwd5MCPqJ/zn5SMr8k6InkLxdI2Fzxs+X
	 IO8AkHTY9p125uUqlm9sr+YckAX58734FYRkKtfw+z99mIPy1AkjKZNzuw0Q2rdyo
	 SSk0ZDaLHbm1MiJYWW+8TKoBt10qhdcv8WnX9doTYLJs99znBcrUm/qo3ZPemAmw1
	 6pogviQhcqDA4Gr7OQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.80]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1tpjNH3DhB-00d6tk; Wed, 11
 Dec 2024 14:20:30 +0100
Message-ID: <6a2c2d16-3171-48ad-aad8-65b167352dcc@web.de>
Date: Wed, 11 Dec 2024 14:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <11adee55-edad-4f0e-b80b-cfd9099ab4eb@web.de>
 <78704675-cc81-b635-6161-a2fb91d2b6d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <78704675-cc81-b635-6161-a2fb91d2b6d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DE8nlNuaLbI52qQFJP7ZFDMED/n3/rjgHvv+2nretDWzPEDHkf6
 ylYG245iTIippnaMNjq3YioEwp63GMqf+DBGJJM83/w6xu68TcHyvgHSD9pH5nMYTh9HCFr
 ds0kjE/On6QH4Ag32R98AuNsoZVwruToyK5aIVkiwTa73pvzo0xsrKvlHYGq0O03q35dm7l
 IsLbcX3ehyPaTR2JONctw==
UI-OutboundReport: notjunk:1;M01:P0:NYK2C5XArsM=;OHyBK/8T0zCNvPjlWnfRBYQUhoa
 vW4BiVb1NLMxA1SBWSjhpF6riCKmpr2L1nShzNK5AJQiHSM9DJ1enj7i/olkUFZErN/Mo9VXy
 gaDdAUO0JR3hNEli/HY95365vqrJSSsNDcYPk9d9qwdFWPHiUBIaEmYnKxj2hrU2PcrUuTBbN
 e4J/v/UpwjRTRE7BjHWPq8KfAZ+rFiCHypzdlpkiSOWREubdx8VuwZcahIydtRZB+xYSlkXET
 C/4QY+M/HHr8z5zBqgBXMom1Hy/vB5D6AOplgKwfwdymNuPOQwnWRoNVUa2AIgz0gBDxWS8+s
 C2Ya71bf0ApeBIzLpJ0JY+MSpr6pSeBJzkVWD69rtdOwNYpY5gY20nfV2SGQqDarnDxwcxOCu
 nUEeaWydrmNKTYtf4+lum3pTgVhKdHQhxwgem/Zbuq3F9XXQCOdhP5peXz90b/C5pEuBtHd8q
 srLcDceBg8E2CpyXnuP+VE85HlgYpolLGKPSuKQ2LXDiWTjVuUwWh7HXig23/f0Af5UVULUHJ
 THQ4LGR7iNExTlptghgOrM+e9ixOQop6hqal9S6Kg2MxYnG2C5h0vROs5r4mbMU1AxDjS0Orn
 NCE3i713DYdv9xnxLUk1BmKtxrgsjOHm4JNvfKOv6uIbgdO9OZmAw4FfDF0p3xB9KnVMPJiQ6
 bbzWza3QLhm91QW029pm46Zs5sSxG+38tJIbq8je5qq5opGXxtA6GSy/UNAkmDn7uGFhhT//f
 2q+p6s2ZWA9tLvNMxFst5CoEgly9LgG9eYv9+L+u2uDshwKAZx00PEe6ff0+SSTnr3VZW8+Eb
 mFJcFv+RQU0Zq+s/buWu7C7M69wKjaxryhZgLIxEkBKFQejlX9tO0uxpMBJC/CrMuOf+kb9TD
 H50AwECjuMiD9yyJfDjFXvC/iSIHXYNszXtCl+g/B++odE6AUEBUiXrxop8wMtT+OqXcUHP6v
 PUVgvVZqhZbJpX2f44Lv0oZ7WjuIGGKmpzs50hOluQjtAhM1qg3OwydrvcP8Wh+gn8eCRGc5o
 ghJ5DEhfmgA1EnrX5UxtwHWYasVicqh7mynjk6ImWsF2YVemWDrBXZEh/MiDHYVO7Vww12q6R
 yVA7UbWLA=
Subject: Re: [cocci] Development challenges for handling of selected code
 repetitions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2178
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/6a2c2d16-3171-48ad-aad8-65b167352dcc%40web.de>

>> @adjustment@
>> expression call;
>> expression * pointer;
>> statement action;
>> @@
>>  if (pointer)
>> +{
>>     action
>>  <+... when !=3D puts("Hello");
>>  call(pointer);
>>  ...+>
>> +}
>
> As noted, there is nothing to attach the } to.

I suggest to reconsider the software situation a bit more.


>                                                 The ... goes to the end =
of
> the function unless there is the when.

I might be looking for other variations of indicated system functionality.

* May any statement combinations (also behind an if check) be converted to
  a compound statement (by adding extra curly brackets)?

* Can the possible code repetition ever be expressed in better ways
  besides the usage of the SmPL ellipses so far?


Regards,
Markus
