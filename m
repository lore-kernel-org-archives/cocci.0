Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B2C433F5
	for <cocci@archiver.kernel.org>; Sun, 27 Mar 2022 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qCHVCJF5k65FxE39lHWJWHXDuCboLXDWj56xCdmfGWU=;
  b=iQofyfhW5vCYfXe5K2cU1ZGyuFyTVYpIdIGBptaii6B6+JeQQNbOzYcg
   8AwhS2BBa4OSan36JYZSoGcgoHDOq5cTlQmNvy//oiyY1vGkc2YPTHfuq
   v2BbXxMHUBoWcVBgrwpsG4oPZVos+2CdIRhGYq8C0z0DW0Zvdgk2qZcs7
   w=;
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
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="28503118"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2022 16:12:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F73CE4370; Sun, 27 Mar 2022 16:12:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BDD93E436E
	for <cocci@sympa.inria.fr>; Sun, 27 Mar 2022 16:12:32 +0200 (CEST)
IronPort-SDR: +t2EAgxAqx3Gs34Wh40dXCzRAu9rj8OPPsuOjG+eD8Y6eOkhZM2PevdQyuZP7ogdl8AluDZKs6
 59Dj54YUYrfBZvldr2s1DlurA794fus/kQJ4tuZYe5PGYaXktKBO972+CWwvACnnva4POxld9E
 Vs8hISYv9ji3jCKJxht10q5lO4hedKu5Q0YAw3o31eroxTvpodGs5TIy5gjRMImu0dzH/YFVrj
 v5x0jvswMBdDCyzGL8+BXkGupD6RFzdY/hIUGntLvGL9msCzmFtG5ki7ZCsvxC2kQqANcP6vdq
 2s/bLkZ8YO0TvhF0USwpyScm
X-IPAS-Result: =?us-ascii?q?A0CAAgDyb0BihwsR49RaHgEBCxIMQIFcgiaBVSsEC0SEV?=
 =?us-ascii?q?I5zgiiLJIcZjCMLAQMBDUABAgQBAYISgmsBCQKETgIdBwEENQUNAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBS?=
 =?us-ascii?q?wSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBg0IAQEXgmmCZQEDD?=
 =?us-ascii?q?SWuF4ExgQGCCAEBBoRIHywiUoFcCYEQLY1PeicQgVVEgTyCUzA+h1+CZZo2b?=
 =?us-ascii?q?5NKj1KeRzQHghKBOoFBDJ4RBhQug2IBkmAOBpFvllynBIF5gX0zGiSDOE4BA?=
 =?us-ascii?q?gECDQECAgMBAgECCQEBAo4dGYQMii0/NDgCBgsBAQMJhUcBAYwXAQE?=
IronPort-PHdr: A9a23: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
 iWcGN9qDWpq4854Kl6JzHDj9tSuZozLddxK/hyMz0Wa1rITcshu0KNQ22w+YzK65yBAqaZzj
 AQyj8vj5s7dcTorpf//WlkCa3X0f59BoGi3y/wEwYDPgMb3Wc8+UjQTAMmyFK3uT2hU7KW9c
 VzSQHpm+xL5UfLeBVPNuB0g9iySVcn2ZjfPYyNHhdR6GEvHfRMZ31pSBm1l2MZ+TF/ixdS9I
 h0guXZOvBih+0EKlL4vbUeaMC+XpR/0OGduDsHBcVwMtFAEvhyNec2GsrAjRWcBoMDn9lfVb
 DbBL0FBCWVDMqCdL3bkOLTmpdzJ8uzDQ/G7M+OLerKW7+pXS/aPw5urlIpg5TeFcMuVbDFkC
 LUg10xPUGoceYyRkigTSyERiyPGbtKK7Ba69Cptq8mj8fPtEAvx7IqLArFWPJ1h4RezyauEM
 ueRgm5+J1M6ntsUwmTUzbEEwFMIoyRpaiXrDrkK8yLADerRlqJREx8HenZzOc9PvMdelkFGP
 c/WjM+w16Yt1KdvTQ0fChq4xYfwPJ9vQSn1Ll7MCUeVOa7TIDTKx5qyeqagUfhLi/0SsRSsu
 DGdGkulPzKZljCvWQr8VIMExCydIhFav5mwNxh3Dm22BvfvcB6mK5laiTMswLs7rmzHPygQP
 HIvFiEF5q3V9i5ejvhlTiZZ6WF5KOCfhyuDx+zfN4pQrvZhRCh53bE/gjxy2/5e6ydKQ+Zwk
 S3Zo4t1ol2opeKIzyJuTBtErjsjbGOjuEJ/JePG+5MGVXuWpHrlAk2PBh5Mq9Y3U7UHXohPx
 9KJmK+hcF9/
IronPort-Data: A9a23:lgUbmK6hYWpEJEPoTqds9QxRtBfBchMFZxGqfqrLsTDasY5as4F+v
 mMdXW/VOvuJYTCgKN9wOtzj8UwCu8fXyYU3TwBqqXpjZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yio/JWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 NVd9pKAUwYqB/PRlr88fxt3Si93IqITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW9LN0nra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6DitIACgWth2aiiG97gd
 4k1eBVJZi7BchJkGGcyKLJ9t/yR0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc9JPa
 EIk4CstlPYv+heKYtvSBhOxv3HR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65VeqdsCi
 Qbhoj/5OdB8mODNFSnHqt94uRvtaXFFdwfucAdeFVNt3jX1nG0kpj7iJjqJOIuyiMH8Ezjt2
 VhmRwBj2elK1abnO42B/V3GhTaloJSMdgA84he/Y45IxgZ+eZLjeIGir1TWhRqhEGp7Zgnf1
 JTns5HAhAzrMX1rvHLXKAnqNO/wj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaN5VMKvc4PZCP3MvYfj2eN5yICkviI+TPNCaG8UzaySsMqHON61HwyNBDLhQgBbmB2zf9kZ
 P93jvpA/V5DVPg5lWPoLwvs+eZln2g/w3/eX5b201yu3tKjiI29Gd843K+1Rrlhtsus+V2Lm
 /4Gbpfi40gBDIXWP3eGmaZOfAhiBSVqXvje9p0HHsbdelcOMD97V5f5n+h7E6Q7xPs9qws91
 irgMqOu4AGl1CWvxMTjQiwLVY4Dqr4i9CpiZnZ9ZAzANrpKSd/H0ZrzvqAfJdEPnNGPB9YtJ
 xXcU8nfUPlJVBrd/DERMcv0oIB4Kka0iAjIMyf8OGozeJtpRgro/N74f1KzpXdUUXft7ZMz8
 ++6ywfWYZsfXAA8XszYX/KYyQ/jt3Yqnu8vDVDDJcNeeRm3/YUzc37xg/Y7LtsiMxLGwjfGh
 Q+aDQ1G9/bAqck5/YCR16yDqo6oFcp4H1ZbRjWKs+zpaHOCpmf6mN1OSueFezzZRVjYwqT6a
 LUH1ez4Pd0GgE1O7dh2HYFr+qRitdHhkLlXk1Z/F3LRYlX3Ub5tLyXU3cRLsaERlLZVtRHvA
 xCK/cRGf6qEMoXpHQdJdgYia+2C09ASmyXTtKhkfh+luXUvpLfXA19POxSsiTBGKOUnOo0Sw
 dAn5Jwc5Tu5h0d4Kd2BlC1Vqz+BIyBSSakhrZ1GUobnhhBykwNHZoHATDD76teDZowUYEUtJ
 zaVgovEhqhdnxaTLSBsSCKVhecN144TvB1qzUMZIwrbkNTyhsgxgE9b/wMxQ1kH1R5Aye9yZ
 jNmOkAdyX9iJNu0aBWvnlxAGj2twDWc/VHtjUQEnivVQiFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmHxWyjXTuCkATZwH4pQUA8wxD8ZYUZy+AB8fxL2+yaEpN8bTeNbmpCo4YXg0OPPP7dT3Era
 QWnECicpEE72eMtT3UHNrSn
IronPort-HdrOrdr: A9a23:9xFIKaxuYtrnyFDmYtZYKrPwCL1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,215,1643670000"; 
   d="scan'208";a="9725497"
X-MGA-submission: =?us-ascii?q?MDHgp/sGvbtFs/UisDcB6MvkzVeYL6/uVp5nWr?=
 =?us-ascii?q?ItWfiNU9ALUhdwUxxKNSoMeZGNXfCcF1+cHSCtpKG7ALxDVsK9lMW7xi?=
 =?us-ascii?q?Ht1aot7/rhjBrlVJ41q2XF5zr/s9uFhgTYahOD2aRigwRX5JpBSbdcDe?=
 =?us-ascii?q?/ZoxBnAlPL2Yuq8s0cxdwl2g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 16:12:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648390351;
	bh=qCHVCJF5k65FxE39lHWJWHXDuCboLXDWj56xCdmfGWU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QOmsuZhKkElrn7ngGt0MmkLQY71n4/KYtNYC+710FwAWCAcH8DHfReQk8UxxGSL/E
	 NI6SAGk/NqM7kIgsGhjsb2v9oDQR5pdZdUWaSops1xUZCNJk51Ahser6iB2WBGFNDe
	 zlBeYLVE6C9mpEafZx/1QMbv2FxGnaH5RV5si9js=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.165.68]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1nf4H03Y2i-006o3A; Sun, 27
 Mar 2022 16:12:30 +0200
Message-ID: <81a44123-bbbc-3f90-f2e9-37b6d6eb5fce@web.de>
Date: Sun, 27 Mar 2022 16:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
 <243b180b-6fc3-1003-a592-1fc01bb198ad@web.de>
 <alpine.DEB.2.22.394.2203271352240.3119@hadrien>
 <46702ad9-17f2-9be2-d985-c89e207786d6@web.de>
 <alpine.DEB.2.22.394.2203271450370.3119@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203271450370.3119@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uYRrRMHebrPCp3TR1arpa1nE1gfnorCzMDjClqeiwJOnHdtXlME
 qLFHxlzH/yNC0zLE501LsUXqQ9TVsnrszlc0B8VZ51LybMwAbHGCLU8jFupc9DWXiy5ue9J
 2pI6tazrFty+tOhBmF5OLz5B04I5lNxwIpw8gWFUwj7Q9O9emlbGWL97If1cfkkIfqbFrbn
 hg7VxUyPcTXGqYgg7ea4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJ+Ep89E2K8=:MkT0Ou4PLRopbzG7ThJ0jy
 NmJ7/g36RGiIAQpBRmC8RJlWWKIXRQ+mBIR05kDpnS0upoFfDVZDjOcaHtNcEwJhEajsBPvpn
 ZRJRF4stDLJA+MTlXAlJ4JDzHjvKyni3JW2NWhs/wRaYJWrLROaRQCJrQ5z0zJyU87NA+y7wL
 fdu9ay32gMpbChjf8fI2CfY14EdVVqcnNBKiwTOrGhihgVFh/0Nr8D6sUfC7+SzLPLQcQgPA0
 VvhvXc0a16x5VIi+HfVSK144exoirDyYuVkfi+O8GB+QIm/jVNe0by9VPGtrPW6zfMmj92se5
 5SDSXCifEEepaMjsXJHahfaJh7dieFwQkfuUTKUG/IBCQ+5AM7Y8YNBmXpkPy/w2xDHts3lNS
 wGs6fdOAS1snvprt0Af/+a4Xg7yL0lvKj8S1l46EhC+RDnmMlpuScO/CJFUFPTVd81XMHIhTW
 6bANmcLRJ7E3FQSR2Vp82koOlvcNr7Fw9o6mBJw4AgYZidLM3Ua0M80VKZ9LlVc437aSf7hAH
 bQH6avosG2w1kTuV+mkJ/VjhHhsR3rv9Iaecc2CNZzYwbIGU8zGguKoDZAFgwbPrcju0SQi33
 MElzSZhSUvl/9plXIoRJ34quLq6g5P4fLTZxb2PGDNJJsBXQntNOBXPAzK6c/mEGSTvaSryyk
 7jvjKUAktLwkTLZZKgBduvEnD5aahr//txyTAuCFERxPLHRYs9aRvAVZHGoiitHCe3Eh8wfww
 uPmQ7NzRmlRI9dPwQH4L9RwVxb59q+eihmzs+1SuLOt63voXza8zbC13uUOqQ+JyPEI+TYy8E
 6SssTYd6abvMo0aei9Z6UbLOhYpjOVQ5vQYpvrFMeAlGZwVMpdjn2fq2qqkq8bVP9CiJPWZbj
 0L+BE4RbmkBZaFxn8dP2tdHbEVucCDtd8pgzxon8aMxdxNbMPnCXeFF/rA08XUpgTRgZTwGhK
 /uMKcCa4o7JXpzy1X2v0pxLsOfT3u5BgOrl6opahpYA4ARVrmbElOlaYgQYuvj8AEBxX054CL
 cnHugN8mhA5hCGaNll+PO7o0SeO9Z0R/QnlQsJtLomepiotbQ5GpiMILHZa9xFBrnpFOcuD9F
 obkdOIA+cbrv/Y=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 298
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/81a44123-bbbc-3f90-f2e9-37b6d6eb5fce%40web.de>

>> I am still looking for ways to avoid undesirable side effects
>> in this data processing area.
> OK, but as compard to situations where there is no solution at all,


It is obvious that some open issues are waiting on corresponding solutions.



> this is not a priority.


I am curious how the affected software components will evolve further.

Regards,
Markus

