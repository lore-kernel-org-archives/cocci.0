Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F885C433F5
	for <cocci@archiver.kernel.org>; Sat, 30 Apr 2022 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gfEY5zgbjfKqrY1qRzfaOcVmvoDOCTO5iWqrCSQxrGM=;
  b=Ya9Wi1kuRkztr+qyTjJEaK5JITw6vOUFvzc6E8nzEwgyuuPIXAJcFqus
   o1DH6DX0BTGlCCd9bdKmmOLnjBVqQIIVlt9BPhLCj26p1gZ6JmrqnZaHk
   cuuR7FE/glHTY+wcC2cFbIUfRlRKQ8LZNzRhHeA1rLxtL/oIUKadkJOOF
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.91,187,1647298800"; 
   d="scan'208";a="34062740"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2022 12:27:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BBA53E00F5; Sat, 30 Apr 2022 12:27:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5EBD2E00BE
	for <cocci@sympa.inria.fr>; Sat, 30 Apr 2022 11:06:59 +0200 (CEST)
IronPort-SDR: 7po/pFYbZdDogYeZqfEgw8vbeSc5/OC2v/mxbWQEk+YZjfhM5W7j7xTtGd+bI0y+FRPWsj3BoD
 nipELABya71JAIsCOjxIabbQUx0j7diio4sWa7mo7BBSKOFLGfzlG+bKwNNUgFhpTjV9Espojq
 sRF7yK81HnWsmAtvfxPecfO2tohBIp8c5Yd3s5src9rN5uOq+b3jmV3PklVqiGnnQxede0KF3U
 yYps080p82/JPFrd/BBJPVzL+NvzO7xB924b1xSEJTzJgsh/VnJEn0xQ31ZLI4Jh8FA5D5VQNE
 n0gkh8WUAfpTz+ToD9YjoMrw
X-IPAS-Result: =?us-ascii?q?A0BnAQBS+2xih37yDFBaHgEBCxIMQINzflUqAwQLQwOES?=
 =?us-ascii?q?4kAiA6eXgsBAwENOwcEAQGFAgKFMh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEBCw0JBQgKBw4QBWNdCDWBT4ICCAMxDYI1KQGDZ?=
 =?us-ascii?q?AECAyMECwEFQRALDgoCAiYCAlcGAQwGAgEBgnkBgxsLrkV/MoEBg08BhEmBX?=
 =?us-ascii?q?waBECyKP4QaN4FVRIE8gwM+iBuCZQSWcRkYgRFskmiDN6sENAcpgVSBUYFBD?=
 =?us-ascii?q?IlLlFUGFC6WSRSRdy2RBoUuII0BmXqBeIF+dIM2EjsBAgEBAQ0BAgEBAwECA?=
 =?us-ascii?q?QEBCQEBAQGONohthUw/NgEBATYCBgEKAQEDCYxnAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:grUFzaquAtwbtZX2vmWVLtx7I3BeBmIoYxIvgKrLsJaIsI4StFCzt
 garIBmGb62OZ2KheN10bNmy80lV7cPTn9ZqTApt+3w8QXsV9uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0IHR7z+l4
 4uo+ZWDYwf9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSLc19xJZ/dvN4ZXkNeSxlfGL9a4IT+dC3XXcy7lyUqclP3xul2SlozIZUf5/oxBntH8
 /MVbj4XBvyBr7LuhuvhDLMw3IJ6dpeD0IA34hmMyRnSDewnWozEW6XHo91R3TM0i9xmAv/Yb
 sYebnxhdnwsZjUWYAdLUMhvxI9EgFHmeRlC9UKk9ZMdxHf5kQ5pi5XWPuvaL4niqcJ9xBrJ/
 TKfl4jjOTkRM9eUyBKe43e0j6nOmzn6UcQcDtWFGuVCm1iP3jRPTgYTSUO8vOX/jVS3Xd1Sb
 UIOksYzkUQs3HeRFoHmbQycmnqJ5BhEY/t1AfEi0zjYn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBW2YHXFq9Fyj1y1uEkd+hEXRFfTJSP0foWSNfuIKz/+nfmzqSFo4LLUKjsjHiMR/Kq
 w1mQQAlgqkL1ZJNzKCn5Vfan3SrvJHPQQNz6B+/soOZAuFRO9LNi2+AswSzARN8wGCxEwDpU
 J8sxpL20Qz2JcvR/BFhuc1UdF1T296LMSfHnXlkFIQ7+jKm9haLJN4NuWgmfRY2bZlZIFcFh
 XM/XysPtPe/21P0PMdKj36ZW5xCIVXIT4y1D62NN4ImjmZZLVferH02DaJv44wduBJwwPpvY
 P93gO6rF38cBqkP8dZFb7h17FPf/QhnnTm7bcmjkXyPiOPCDFbIF+ttGAbQP4gRsfLcyC2Io
 o03H5bbm313DrakCgGJqtF7ELz/BSNmbXwAg5cLLbHrz8sPMD1JNsI9Npt8Jdw4x/gFyragE
 7PUchYw9WcTTEbvcW2iAk2Popu2NXqmhX5kbyEqI3iy3H0vPdSm4KsFLsNlYrAh/eBkyrh6V
 aBdKcmHB/1OTBXB+igcPcCl/dA5LkzziFLcJTehbRg+Y4VkGV7E99riSRfiqXsVBS2tuMph8
 rCtj1uJQZcKSwl4ItzRbfajkwG4sXQHwbogQELOK9VUfwPi6tEyeSD2i/Y2JeAKKAnClmLCh
 lrNW09AqLCU8YEv8dTPiaSVlKuTErNzThhAAm3WzbeqLi2ErGeuxIl3TL/ULz3QUWXD+JKia
 /9Q+PfyPaBVh11NqYd9T+tmwK9itdvio7hWklZtEHnRNQ75EbZ8Oj+d2NVXsbBRgLhDsA25V
 wSB4IACa7mOPcrkFn8XJRYkP7Taja9ExmGK4KRnOlj+6Q924KGDABdbMBS7gSBAKKd4bdE+y
 uA7tc9KswGy1kgwPtCdgnwG/miANCZcAb4iqolCXMnwjxYzzUxeJ5vGAyn57deBcYwUYEUtJ
 zaVgovEhqhdlxqbKyRjSSCV0LoPn4kKtTBL0EQGdgaAldfyj/Mq2AFcrGYsRQNPwxQbi+9+N
 wCH7aGuyXliLdupuCRCY4xoMxpEGAXf4Unt01wUiCveVUCuWWGLIndV1SNhOqwG2zo0Q9SZ1
 OjwJKXZvfLCY8j31yc1XghrsZQPiPRvoxbalpnP89utRvEHjPmMvkNqTXUBrRLrBsR3ilevS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:UMNXTa0be+CwfKeVtzfNfQqjBH8kLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdqZJhAo6H6BEDuexLhHPJOkPAs1PKZLXHbUQiTTL2Kj7GN/9SIIUSXndK1l5
 0QFZSWY+eAb2SS4/yKhDVQX+xQo+WvweSNqaP302ptJDsGV4hQqyNUTiuSD0EefmV7LKt8ML
 bZx8ZDoVObE0g/X4CeKj0kZoH4yOH2qA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,187,1647298800"; 
   d="scan'208";a="12840290"
X-MGA-submission: =?us-ascii?q?MDHo9n4GMPTRjqMxmm3RoLOyDYPmwGUkt6WNX8?=
 =?us-ascii?q?b+92vZLzRGvVcFoWDPL6SbxpYvfQN/9k8EMBM5fFyh6H+2i21ADhfXTa?=
 =?us-ascii?q?3vf/aNUikQDGqBdaVsepYloIi51gHGNBZdvPFPrsnElw44BT2FkRKOp7?=
 =?us-ascii?q?vY0sMIeGcTmxkIdI+W50xyzg=3D=3D?=
Received: from smtp04.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) ([80.12.242.126])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 30 Apr 2022 11:06:59 +0200
Received: from [192.168.1.18] ([86.243.180.246])
	by smtp.orange.fr with ESMTPA
	id kj42nAiNWPp5ukj42nS5Lg; Sat, 30 Apr 2022 11:06:57 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 30 Apr 2022 11:06:57 +0200
X-ME-IP: 86.243.180.246
Message-ID: <c920e37a-b690-e614-c052-634177bbeb46@wanadoo.fr>
Date: Sat, 30 Apr 2022 11:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>, Wan Jiabing <wanjiabing@vivo.com>
Cc: James Smart <james.smart@broadcom.com>,
 Ram Vegesna <ram.vegesna@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr
References: <20220318145230.1031-1-wanjiabing@vivo.com>
 <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
 <eab847fe-8d17-1a38-b55e-e68a2f6a1829@linux-m68k.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <eab847fe-8d17-1a38-b55e-e68a2f6a1829@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] scsi: elx: efct: remove unnecessary memset in
 efct_io
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Loop: cocci@inria.fr
X-Sequence: 364
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/c920e37a-b690-e614-c052-634177bbeb46%40wanadoo.fr>

Le 30/04/2022 à 09:48, Finn Thain a écrit :
> On Sat, 30 Apr 2022, Christophe JAILLET wrote:
> 
>> Le 18/03/2022 à 15:52, Wan Jiabing a écrit :
>>> io->sgl is allocated by kzalloc(). The memory is set to zero.
>>> It is unnecessary to call memset again.
>>>
>>
>> Hi,
>>
>> Nitpick: this kzalloc() should be a kcalloc() to avoid an open-coded
>> multiplication when computing the size to allocate.
>>
> 
> Seems like kcalloc() conversion could be a separate patch. Perhaps it
> could be done everywhere using a coccinelle script.

Sure it can and I guess that many coccinelle script already exist for it.

I only replied here because of a comment from Joe Perches on the same 
patch a few month ago (see [1] and [2])

So Wan Jiabing or anyone else, if you want to go one step further, just 
feel free to propose it.

CJ


[1]: 
https://lore.kernel.org/all/4208b3d08a677601c73889f78dd25e5c9f056a86.camel@perches.com/

[2]: 
https://lore.kernel.org/all/9be7d5beb437583f8d975d168ac5c3e32fb6e465.1639158677.git.christophe.jaillet@wanadoo.fr/
