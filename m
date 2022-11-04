Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78FC4332F
	for <cocci@archiver.kernel.org>; Fri,  4 Nov 2022 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jrvksMg9pfOAK1a7Q0+HWNSDsN8r3mESr4h/5AYBoIE=;
  b=cy29+Ef/u7cDUAF8Avp569jGjL5vkd7ZNmQuEhqHS9k7JCP5FOwoKhLQ
   nVrULsSC7QqIr55yPRGczDtIrc7xBJ/zkugFsWdCPcZMBtfbzJXdcG3Oe
   ST/uLcl7Va1HevuaoWyrD4txWg6cb6abzISJzFjvo/LokrHR3eAxrXQl+
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,137,1665439200"; 
   d="scan'208";a="75039157"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2022 10:48:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85E12E039C; Fri,  4 Nov 2022 10:48:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4258DE0157
	for <cocci@sympa.inria.fr>; Fri,  4 Nov 2022 10:48:41 +0100 (CET)
IronPort-SDR: 6364dff8_sjY3+xvGy4T0FXuX3st5ClqU4sCh43QGaettU8kYW1juMDV
 LeOET1o8JkSDmgZIwSX55cW9GT9UIjp4Kjrs8Ag==
X-IPAS-Result: =?us-ascii?q?A0CcDwCy3mRjhw4P49RaHgEBCxIMQIFRgiuBBVMuBAtFh?=
 =?us-ascii?q?E6QbDGEKYcdhy2KNoF9DwEDAQ1BAQIEAQGCEoJzAoR4Ah0HAQQ2BA0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSkBg?=
 =?us-ascii?q?2QBAgIBIx0BAREmAQ8LGgImAgJXBgEMCAEBgnmCbgEDDSMHq0GBMoEBgggBA?=
 =?us-ascii?q?QaYEh8sIlOBXgmBFC2MTYM2eicQgVVEgTyDAz6ERINXgmePAIdxJgQOAxkrH?=
 =?us-ascii?q?UACAQs7MgMKSxsxJw4JHxwKBBcNBQYSAyBuBQo3DygvZyscGweBDCooFQMEB?=
 =?us-ascii?q?AMCBhMDIgINKTEUBCkTDSsHI3EJAgMiZQUDAwQoLAMJIR8HFhEkPAdXOgEEA?=
 =?us-ascii?q?wIQIjoGAwkDAiRYdAIvERUFAw0XJQgFTgQIOgIFBlISAgoRAxIPBiZHDko+O?=
 =?us-ascii?q?RYGJ0QBNA8OFANegW0GNZ07gSSWFaw1NAeCHoFMgUwMnmMGEy6DZQGTBw4Gk?=
 =?us-ascii?q?hSXMCCnV4F8ChaBWzMaJIM2TwMZD44gGYQMiixANDsCBwEKAQEDCYVHAQGEd?=
 =?us-ascii?q?QEB?=
IronPort-PHdr: A9a23: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
 JdcE9dm
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ty1CxKOyb66+7cBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,137,1665439200"; 
   d="scan'208";a="37868619"
X-MGA-submission: =?us-ascii?q?MDGLPyIfOwDIhe+Bdg/y/Dq2be0fOZCB/W64Ij?=
 =?us-ascii?q?UPW8agD4St9yU9Li+xZj/HIWY4wtgiArfxhobIliy7MGZIqiCg/86ZDZ?=
 =?us-ascii?q?afz6tetZCV0A36j9w+HQn+22/2LqI1mtluxstyQHAmyjmImJZeVTLLIf?=
 =?us-ascii?q?pVwrvDV0OyIRv/9P5aRNyyjQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667555319; bh=DHzwEaUfzlmB7FIPGWyGWFMKx7BNL61Y9+9iJlCTEe0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=By3B3L2mnRwbzbZDVlS0/eAA3IIz6AXmoANgbYj8I6SFDlEQyYV3/0mqyJdK9tmgC
	 U56PpEYDvWL50tmUTYtsV4/GDqeWzfpWEqb8bA2U/XwVLd0SfGdVgQAjtOjUuUdUJq
	 vJaPElQd84AdKbIRbFG54ftKOCxroODvAhkLxc/jGgGOOUrpd3CIhre2+rykHlW7YT
	 RJiAQgVbAkK3L6a4PCfDYkqt4tVa/LrrOEBBQ54Pry7btr7lrilzBRuDjqrXnlGcdK
	 KJgPNggwxYEehxfE54wgQOepy0Y+dI5vQv7OLnbF6fUTqalyYyMVTRM1E64tiseem5
	 tCToXGqtLLG8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkEhR-1pJePu0K5Z-00kfS5; Fri, 04
 Nov 2022 10:48:39 +0100
Message-ID: <d3f2dcd8-e158-d018-01e6-44163c2fcb42@web.de>
Date: Fri, 4 Nov 2022 10:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Sebastiano Miano <mianosebastiano@gmail.com>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
 <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
 <3a2a50ba-8c30-43c5-354c-7b194eea8df0@web.de>
 <1baafdcd-4e98-af8e-4697-bf37c43c6135@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1baafdcd-4e98-af8e-4697-bf37c43c6135@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2bZfTwfWvqEmJYYIBw2E+H6Ze+icihPmTVkApFAbe+EoA2vtRa1
 +TrwOm5g8FJcP040di3iqesBIUe4U1cnji+/vaivMBKRNDvuZwg2IxAcDshRU/F7UhFZ2rz
 PeW/qrGiF77yvYBz8hNL2GmWM9IXVYcarI6aM0O1g+iUt4c0/O9Tg71oQVFQdKt7ApkaYfH
 Aslw82ppHQXTXr5jD/byQ==
UI-OutboundReport: notjunk:1;M01:P0:yK3H2KbhkMQ=;Ox3m/+RoMHLbwzExpXf++NLS9FT
 H5BaDHiJXis5tCMt8A260IIBd5/qw6otp8Iio0FP0Xp9U1sHGXBdh+nOGqGkVwjKTUtN0pRwZ
 KCQ4+MOAZGrLDjjMD4jRWKr5/P6Ns1+iTIG0QbYrXw2yDqkjNajoSS2wSVolGHVgLxBglHa4V
 KhnPcCWETdXH2JqO9GtGdx3EChvslcrQDA3KP3H/gZlTwexLB6vvhQ8svJfaYqG9HaUiwd4SC
 5RY9AmrSQYG2LB5pNcPShxD0A8sdlexRBvV4RLhxTtDNizMeVNM9ZhTpy/Rcmn8SucBW9OvXi
 pVRI59ZPoHzqQ/7S71Fuo6CipUueCqsnoqubQDBdJag7kOq9qPQfdlQkX1VldGYmz5tEDZEDe
 nhTksTA5NVunHkwBi35FZVk/3XCfb2Fsk5iRkpg41oMPbs4tw1zhiKGAc2z7L0JvCL37tMAYC
 Rf5DKkmYzRaPI7LuYE9r5UbWPVgRt2QbgvW+1WEo8LIKOuif2ir0cUzyqcugaIOASRbaBIqiT
 o0PAyvdnb77Cyo1l18TVPRTcdo4F7XQvYuB09LhV0m1ZH77gKQqw5qMhybJOkuAT70oAKf/Sx
 6/hWfwoGTgye0Byd72+ObCxRAk6I0bShge0D10XBIumuzMiWMGbttiLR8aXCNeR48Y12hwCtP
 DU08lp0ti5yk6AmsdEOK81D7FU7UIuEKhZez8oNARGsH8uD+BaWt/pUkQvKI1Z8KApbgxSG+R
 eVstS/EHUcZCbWtBatG9KTCi2WPKuGoHzTYcVnfhAA++H+8RNMVaTljhGkAlVCYl910IJumtQ
 momxEGkH8wxx0WJAsnwqABnDjbbapjN2gajFTswzkxKUYfQnxjPw18O7fS5mn5COV7S6D12j7
 B9q7vtoqOpklBulEViuK2sumLYaM6ABvy9k2vLB2wRbi9CMB9EvIAjqhJu3wWRQBa5l48svXm
 GXG3Mg==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 716
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/d3f2dcd8-e158-d018-01e6-44163c2fcb42%40web.de>

>> Do you find the metavariable type =E2=80=9Cconstant char[]=E2=80=9D mor=
e appropriate here?
> This is a reasonable suggestion.  But if the rule works as is, then it's
> already fine.


* Will developers become occasionally interested in different software run=
 time characteristics?

* Can interests grow for improved handling of string literals (also with h=
elp
=C2=A0 of the semantic patch language)?

Regards,
Markus

