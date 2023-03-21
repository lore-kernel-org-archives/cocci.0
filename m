Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A569C74A5B
	for <cocci@archiver.kernel.org>; Tue, 21 Mar 2023 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CT7xHXG8JhBeOVufCmoBkVwuGJ+QQcGx0Cjdf+u/rjo=;
  b=aduwML9LyZBJLnsNhrDGNOjdHT6VsJ7QwsceqwrGS3aTBb/8oMZfe3UR
   5ZhAZzzRqalNHrhApd4Q2GsPSe1oUeoInU3puUC2AKm1hrnieU9LiNVll
   SJaZgdjtbVAP/U05cX0jD6I9Bc9DrGzwwkOGSvxqHJ1no3/q0suuYT9Np
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="98259168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2023 11:31:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5CA55E0D3E; Tue, 21 Mar 2023 11:31:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 601BAE0131
	for <cocci@sympa.inria.fr>; Tue, 21 Mar 2023 11:31:05 +0100 (CET)
IronPort-SDR: 64198768_/u0kdApuuPzcSjwNhkrJLAHHvrlRZa+pywg8nvz8144k4bS
 S3p9NNyaf696DSdyNeDkSDh+xuPqW68yPz6BWWw==
X-IPAS-Result: =?us-ascii?q?A0F+AwAzhhlkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTjwqBdzGEL4cshzqEZ4QCgWqBLD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IRGAoU2Ah0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBARgLFwcOBQsFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIx0BAREmAQ8fBgIRFQICVwYBDAgBAYJ6gigBAzEHs1aBMoEBg?=
 =?us-ascii?q?ggBAQaCY5knHywiU4FeCYEULI0EgzZ6Jw+BVUSBPAyDNYN9gQaDGYJnmQ8Kg?=
 =?us-ascii?q?TR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZQsOb4FLAmRNLyUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxDDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA0+BRwSBC3wKBgEmJJ0KexOBTJQTsD00B4IogVWBWQyfDAYTLoNqARKTC?=
 =?us-ascii?q?w4GkiMuhy2QDyCCLqVMgXkjgVwzGiSDNk8DGQ+OIBkeg26PCQE9QDQ7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 v8ejwxjfaIy+T2q71plfjL3
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:pwwFJqCVZRiYVW/lHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="50790738"
X-MGA-submission: =?us-ascii?q?MDEpoIqN/RUkRMYzyRN3lLf4Ct0J6Txu1KAL3b?=
 =?us-ascii?q?FJFhrWjN+g+8DrfFwglgQnaBwIUkZ52/++bpo+orqEPRngRM/Dq/Uno0?=
 =?us-ascii?q?rTFIe76JqiAlc/rxedNbQpeGmFbiHAtS2nQeugSJm/JBhDyGrptg/red?=
 =?us-ascii?q?ntCzvXjjtiuKr2zZ2iv9WtKw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 11:31:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679394657; i=markus.elfring@web.de;
	bh=CT7xHXG8JhBeOVufCmoBkVwuGJ+QQcGx0Cjdf+u/rjo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=q8Ner4fyHjhZM3MaiXKTZ6CilhhyzZJc/gyP7RQ+qmNKPyAPDxEkRP78nX7DvGouE
	 HWFI9yJfxr3xFXmponEhY/MDX+Ho+g4ZwU2tup3mDJkD3w6ixzMhI/n0Kle8/Z7mXq
	 HpUswXEVz0a00QZycvx/hiAi6fluX7OfaKd/y/k2uz7/M4s38Q45j826csJMjL6+YN
	 7IMAmcTXfeZO1W3Zv0uKu7ui+SUtJ6tTeo1Izy9a3JgjwyQNntgu+7Jz9QXYQwPgtb
	 nQU16R67FX30cWu9dFRWsf08fi0iBUf06mWtSbTgSdB2erDznE1NXf9dY9L4GncUwS
	 h9ZwGXY4WAyyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8Wg-1prqvg3li4-00MGg8; Tue, 21
 Mar 2023 11:30:56 +0100
Message-ID: <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
Date: Tue, 21 Mar 2023 11:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
In-Reply-To: <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SLleS0P+H73Nybkhw8BxrdfS/dXDDovlM3aLN+oPSrpwr76OOc+
 rzdxlaYdZ57zLjQzG7CKlLloAPFukKnt2yYW76WvVOdL3cPE8aIutleaC45LyLxrx1YB+og
 BxdHjHpbRU1hL+PxsHPg8XNvQBoJGko6AI3HXHGZjgCwWJlS2QmdkAfVlia/IKOVWLJdFw4
 cHIRCAgnsYKWInFirH7gg==
UI-OutboundReport: notjunk:1;M01:P0:WVBGSyKNTaE=;9fsatsBPW+TcfwzouDdkJeHRc1R
 al4qDFd2oRGDmBC629xDeyNEmF/sn5NAVVNvJSxg6PJ5gSR8JNpYFekonxmdrshPCCgFny/mD
 uALTIunjwdIKTG1gAh1b5GLa3izxUvlxyxG/gXUhjb/EonxMjCXNUTPZQPMiioSaD0RlpSljv
 FsZiihEG5CsB1NKYhD7VENLjX4qjwJ1Jcj1kRVZFdOh7dToJiWtXZzVtBgBqm6QwJU6Y8rvsQ
 IHTrA6l6kWL9PXHeoIXfNs7fkuygxOaacsqyiFAfuayfn9rn67pW8WInGO0ysBtIQ14D4uE+t
 Td/PrQCclxZcCzi4DgcSP8c8qBGJDu85uTZF+6ef8pBZX9hQr5HcRh91gh2112gp32o+IsFTo
 4hJ24VZ3MaO59ydXcbYxZZ2L9dZytNik00cKpNWYlDZCW1iokA7absyvqsmbvPE7Mk/3B9dP8
 69wOVaPQJCXZn0LvrjlNxM/Jn86DLiqOfIeBKSlHpZ2zKdKG1DUj8szIFUKNYcINZH+fDgFum
 AYppCg+9CRpetQLVf1CwKakGrkB0OagCjxm8hR1yJZvVHid5rQdHbF8itfJ9eR9Iu6654Dvss
 eZT7STk6I7C1e6c+w8aL+7Mg93EXEHS/quspwTZIphtbDx9u8/6QqOzlxh3U7EbA5/GTbwVaE
 OBWzqErLeTvzGa0CWjs1WJGr+JSpgsPGta8zMzqhd6Gz+cFrKERiXMQH5Vud61yFjtelAOShv
 +t4cO71EgqFrIa96IvskQj9PZ50zV2NfOrF/SSC3FvMu/sE/eXo2KrVJTW49/V9fZJzBU3EZ/
 wktEy7hNbXVymtU15qahGNip6LeXwZCCIWgHi+FFcew2uK5mlNp3Cv38TTXtXRwOOSSTfWejf
 lwKtsBpAK4iOAc5Sh6QcdeI/tB1x6y48Wi/o7StIawKo0BANuC8Sqp70ctVBc7GC1+mFwCjQF
 kSjnJw==
Subject: [cocci] [PATCH v2 0/2] powerpc/pseries: Fixes for exception
 handling in pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 906
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d4bcde15-b4f1-0e98-9072-3153d1bd21bc%40web.de>

Date: Tue, 21 Mar 2023 11:26:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
=C2=A0 Do not pass an error pointer to of_node_put()
=C2=A0 Fix exception handling

=C2=A0arch/powerpc/platforms/pseries/reconfig.c | 26 ++++++++++++---------=
--
=C2=A01 file changed, 14 insertions(+), 12 deletions(-)

=2D-
2.40.0


