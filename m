Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77533C433EF
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:45:30 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6826109D
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B6826109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AIBMRN60zi/ZMgaIS/PbD5cVwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhjx2gzBRyGMaWGGGa/rfZGWnf98iaYi//EsO7JLSndI2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHuCjULS?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0O+eeSTl6aR/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZvjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="810420"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 19:45:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DB3AE001D; Wed, 27 Oct 2021 19:45:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A52BBE001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 19:45:25 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AVq0OfxFAvYvzs6iPWoo+WJ1Gf9RMhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31BmYBM6GtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeQFFiCeybb5yLhi9sBncuNQRjYZ+MKg61wHHomFPe?=
 =?us-ascii?q?+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4TadFDDs9KGA6+NfrtRj?=
 =?us-ascii?q?YQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+886lkVgPni?=
 =?us-ascii?q?CYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hSWSJODY2?=
 =?us-ascii?q?zYZYRAeoPPehXrZXyqVQVoBuiBwShHv/jxiNGi3L026AxzuQvERvB3AwlB98At?=
 =?us-ascii?q?27brM/2NKcPSuC+0abGzTHNb/NM2Df97ofIeQ0mrP+LR71wa8nRyVQ0Fw/fgVu?=
 =?us-ascii?q?QrYLlPymU1uQLvGiW9ORhWvy0hGI9tg5+vCGiy8ExgYbGmowb0ErL9TllwIkrP?=
 =?us-ascii?q?924TlZ2bcK4HJVetyyUOZd7T80jTm11pCo3y7IIt5C7cSUW1pkqxhHSZuCZfoa?=
 =?us-ascii?q?G/B7uUOScLDRkiHxld7yyiAq//Eq9x+D6S8K6005KozJbntXRqHwBzQLf5taFR?=
 =?us-ascii?q?/dn40us2yyD2x3O5u1cJU05m7DXJ4Mvz7ItjJYes0XOEjX5lUjyiqKda18q9fK?=
 =?us-ascii?q?y6+v9Z7Xrvp+cOJFwigH5Kqkun8u/AfkkMgQUUWmU5/+z2Kf+8kLnWLlKj/s2n?=
 =?us-ascii?q?bfFsJ3CO8gXu7C1DxVL3oo96RuzFSqq3dYCkXUaMV5JYBeHgJLoO1HKLvD4F/C?=
 =?us-ascii?q?/g1G0nTls3f/GJL7hAojWLnTZn7nhebh961RdyAo1wtBS/JxVBa8aL/7pR0D+q?=
 =?us-ascii?q?sTUDgUlPAys3+bnFNJ925sCVmKIHqCWLKLSvEST5uMvJumMfJUatCz8K/gj/f7?=
 =?us-ascii?q?ujGU2lUUTfamzjtMrbyWdF/J9JFiDKV/rn9kAHS9euwM4V+v3kliFTDBSa169W?=
 =?us-ascii?q?qs94ncwD4fwXqnZQYX4pbWb3zqgVrBSaHpHDF/ERVLhbYaZQLEhbCyII8luuiM?=
 =?us-ascii?q?JX/6tRtlyhlmVqAbmxu8/faLv8SoCuMemjYAtjwUyvRQ16CAyEMmXlW2AHTkcd?=
 =?us-ascii?q?oYgWDI8mqxy8xQVIrirzqVyxfBVR4U72g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYS3xnK+uqpbxndI8C4luk+D8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyYlFvBw5Pre/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ?=
 =?us-ascii?q?2VxeJZg7cKoQeNJ8SWzIc0uJuIMZIObeEYZmIbsS+V2njbLz9t+ri6GLvDv5ak?=
 =?us-ascii?q?856Bd3ARV0lYhT0JdzpymSBNLjV7OQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CbAQASaxphhwsR49RaHgEBCxIMQIFOC?=
 =?us-ascii?q?4MNbDoxhEePSYF3MIQYhlaGcIoKgXwLAQMBDT4BAgQBAYRXAQkCgmsCHQcBBDI?=
 =?us-ascii?q?HDgECBBUBAQUBAQECAQMDBAETAQEBDA0OCDokhWgNgjUpAYNkAQICASMVCAEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJXBg0IAQGCbYJVAQMOJad3gTGBAYIHAQEGhGsfLCJQgVoJgRA?=
 =?us-ascii?q?qjXMnEIFVRIE8DII7BzA+hF2CfoJkiAORf41/nU0tB4IAgSuBNwucewYUJoNTA?=
 =?us-ascii?q?ZF1DgaRGLtWgWcCggszGiSDOFAZDo4gGYQMii0/MjgCBgsBAQMJbAEBiQcBAQ?=
X-IPAS-Result: =?us-ascii?q?A0CbAQASaxphhwsR49RaHgEBCxIMQIFOC4MNbDoxhEePSYF?=
 =?us-ascii?q?3MIQYhlaGcIoKgXwLAQMBDT4BAgQBAYRXAQkCgmsCHQcBBDIHDgECBBUBAQUBA?=
 =?us-ascii?q?QECAQMDBAETAQEBDA0OCDokhWgNgjUpAYNkAQICASMVCAEBESYBBAsLGgImAgJ?=
 =?us-ascii?q?XBg0IAQGCbYJVAQMOJad3gTGBAYIHAQEGhGsfLCJQgVoJgRAqjXMnEIFVRIE8D?=
 =?us-ascii?q?II7BzA+hF2CfoJkiAORf41/nU0tB4IAgSuBNwucewYUJoNTAZF1DgaRGLtWgWc?=
 =?us-ascii?q?CggszGiSDOFAZDo4gGYQMii0/MjgCBgsBAQMJbAEBiQcBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397553664"
X-MGA-submission: =?us-ascii?q?MDGSowmff8OaJ1/FnFPTFM+DrQUK9WBnaSXuPo?=
 =?us-ascii?q?5U32R6pyIhaZXX9vAoz3cvMI3ClodZMvu6khQsBNbs/QDfFPD6qxxKJn?=
 =?us-ascii?q?OUMcJHehQT9sCR7T3PNFZXnjf4Ew1VndPj122YaRoKnrCjViFLf5nXAM?=
 =?us-ascii?q?8yS/ncU8NtD2B8WNkWEud/8A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 19:45:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635356723;
	bh=j+8t2rYEzEWI6Chpj6Ew7OtWL+nAU9+n4dJHUFsQGqY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=I+c3JnS0Kgy1yAkZqjTR8L8+CqGnl7SDdN2JFa7CDYPxPAI3u4zolFqQOSHbrXlcx
	 1XKexYj6CDyfdBqOkcA3W4OTx7I7OGVvIRtkCe+fhxiRrUVsI0kHkK2IlnvVmaubOh
	 Bsc9kmeWsGh0GQyTOPH4qHjEE+PiaVxH9njCjnuQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.76.49]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1mSbh51ppI-00Dfu7; Wed, 27
 Oct 2021 19:45:23 +0200
Message-ID: <a70558ce-1cb4-8219-fe1b-5ffab597455e@web.de>
Date: Wed, 27 Oct 2021 19:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Mansour Moufid <mansourmoufid@gmail.com>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1cDlCBfc3f9ylO1+HsCaG+Bw59FCKeghfPjF5cXtRplk/FsisEt
 +Du5IhudWQSh5jieRAs0JLJDvPb+iMjVvA/OcUkhZbG82ucmQmxhAsd05l2eUXq1v7ex8do
 UHCPhnEyQvYI4nFVufgMkbaT4JVu/ABQn4WFqI+gastTWPBoKtf1WS5dyn7bliA95f1/DCL
 E76OjeAERSqrsypPwwieA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0tPmM6G5K4=:k2/Udhq/lunxyIkghh35Ml
 8F1hXsev9859eiMzDdx3HVF3cEBa/xFZKdtfYNgqqiUZnkHxQHF2LGvoiO+NkmylGgAgJz25V
 La6MIzoCWOYUzdKRSNpbGR5iDXHUtpXuQZyT9S/Q8/Yz0eXLHOSqPHmnOXbVq64TeD0YD10kc
 7mkWVjRSHgH6iioFuIOc6m3UUD0YAt1d/+ZkXl7i03OJGna9FsfQX2JvZTPRgQal7zrY6bvsi
 QlVkDCfWa0r0RXWIIOkvuBzOOVSLsHtrs2tYucPD9g0e0ndYLhl+HNRpHf/5Pdrmb3AUH3vlV
 eNaSFPO6lRyWko+UaJDzFNJczEp9JEb6PeP5MAaoX0sxiC+6L3l5Qs2fwZ2/4O9BfM/NDrj1W
 fUhT4GDBKvYnCeju5YD1VwfXRxpdqkVok0Hr3hkCICqLU/b63rplXlVXuv23EN7aWu0tq8ntY
 MM4dw2DzerYxfbujfqcF/HM0hPe4ybvaS3EQdlOEUS347b2n3l5oaagRd1BcTBpuav2y7eek6
 ENbcrxLXg9jkaHpX88qGQI7ywVzfEk9DVTjRyybpOEt4MNnYMecwKb9rgkrtjP8i6alHrxMdX
 1Qah23F6piQoYDcr/Hv/tEhGZvySlAYZ3F69B9tG5l/DGv/fIBVF4A3UFSvCfhvvYSt4diGdM
 +WLl5Q4RA8SeVqxqjwUnRQxtXrwuN7GoFitfflTIDnl/4okjbMDMElUrVgUvEuQAmKH6ydKYR
 IEGPKNiVMS3H6BT/jDrkDlqx82uw6UcBB0CrAwmSsc1e1drMvRSsdG1JgyJZNFApXDcMttCwd
 Mo1IoFTyPFUQM3I+MnJOm2bOUtzIhYF4oTqODQ7/hPlgMxUqgzfBnhTzb8N7Iwj8xKi7DRs/0
 JloUaHsyFvIrNQxD1VMQFdhW13zkEHn8L9dnZC8/hZr7i/e6U9u9ERkh1d9uvC24mVIBB51OU
 45/lNwXYMJsPxIHXu9KcjIzTLdRNDZ+0J2/rxjQF/Zthw9WcU0HjU7tTSVxe8MjK8Sn5tpHEW
 c49WiZwdXGpNM1yLubzuRmoZL03T8+3J3+UoRIEY6TpvPR7VqrM6wkzA3LEu0t2gEQHnBfvo/
 Of6rtZlWDrprEE=
Subject: Re: [cocci] Print selected status messages to an other output
 target?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 47
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/a70558ce-1cb4-8219-fe1b-5ffab597455e%40web.de>

> I use --very-quiet, but I do want to see these messages,

Why do you see a need to handle a message selection in a special way?


> just not in stderr.

Would you like to become able to specify any other output channel
(according to your data processing requirements)?

Regards,
Markus
