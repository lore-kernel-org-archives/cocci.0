Return-Path: <SRS0=/5U0=PP=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56DBC433F5
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:31:16 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B564460F02
	for <cocci@archiver.kernel.org>; Wed, 27 Oct 2021 17:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B564460F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AOrFy7q3c29OIt0iGLPbD5cVwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ3W4r0TRUmGZJUTiEPqqMa2CnfIp2PYS1/UpT7J7WmtI2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHuCjULS?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0O+fcSnh7qR/yGWDKRMA2c5GB0Y9Noww8/x8AWB?=
 =?us-ascii?q?Q+OZeKz0XaB2HweWsz9qTQOh3ndUtIuHkOYoevjdryjSxJf0hTJbORY3F4NZZ2?=
 =?us-ascii?q?HE7gcUmNfrXYYwbLyVuaBDBahhUElgSAZM62uyvgxHXfzRGqV6Ooqw77WfX5AN?=
 =?us-ascii?q?02bnpdtHSf7SiScgThUGFtGuA9GPjDxcGNdq3xj+M83bqjejK9QvwQ58WEKyQ+?=
 =?us-ascii?q?fltj1megGcUDXU+X1a9rPW4iVKWW99eLUFS4C0lrrNa3EevSd7mdx+4q3qDuQV?=
 =?us-ascii?q?aUN1Ve8U24QeMx66S5wuLDWECSRZFadovrshwQiYlvneCn8noHiBoqL3TQ3WQ9?=
 =?us-ascii?q?rKLpDe+NDI9KW4Eby4YCwAC5rHeTCsb5v7UZs55F6LwitzuBTzr3mna6ik4nbQ?=
 =?us-ascii?q?ay8ARv5hXNGvv21qEzqUlhCZsjukPYl+Y0w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,187,1631570400"; 
   d="scan'208";a="808967"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2021 19:31:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2956E001D; Wed, 27 Oct 2021 19:31:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D359E001C
	for <cocci@sympa.inria.fr>; Wed, 27 Oct 2021 19:31:10 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=nicolas.palix@univ-grenoble-alpes.fr; spf=Pass smtp.mailfrom=nicolas.palix@univ-grenoble-alpes.fr; spf=None smtp.helo=postmaster@zm-mta-out-3.u-ga.fr
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AePqhiKCsZwd+T7PlHema55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoBLSC9Afbo9fxG+85rriMc6QxhIE3I/OrrBEDuex3hHPJOkO8s1PKZLXDbUQ?=
 =?us-ascii?q?iTTb2Kj7GM/9SIIUSXnYMw6U4jSdkYNDSaNykYsS+V2njcLz9t+rm6GC/Ev5al?=
 =?us-ascii?q?vgpQcT0=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397553020"
X-MGA-submission: =?us-ascii?q?MDGen/KyPLOTkjIS3Yhb9PKe8m5VhXiNPC+mt8?=
 =?us-ascii?q?XougOXyMVXelw7QfhqyT8rl3vJ2Lb8++gTA2QKVAdlsF84i4K3lvGeEG?=
 =?us-ascii?q?sTcCzTJDE6bOmToXvjwNET72EHGcudw2IoFpxyg02ypbAsAwhT8lQvJY?=
 =?us-ascii?q?YH3R+gv2SFhj/iDzf0E6wTVw=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 19:31:09 +0200
Received: from mailhost.u-ga.fr (mailhost2.u-ga.fr [129.88.177.242])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id C8B9F415BA;
	Wed, 27 Oct 2021 19:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1635355869;
	bh=gEVlsNPbWEUDxAUc252ZEL62p5F9RuqbL1ZA/n8AqtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l2ymWd/hYd6ml/4QNIKRjD41zPcITFnsWDMVZ3zinIwdGzgSdFj9OVGrUV0KkgNZn
	 tOH0MAQoDTryoAFgwTSid3SBQPz30ZfoiZ3GQOHbHnPT5RC3wKABGz8VBsbOtttEvr
	 wIn1Oij/VBXRF51pakkU0Rt3KFc+FkwOk0JEzCsuI6X4E9xexbO3cXnVj1Xfrh+UP7
	 Pi0UBCXO2q6lncYj3JviCIHUYEK3K9hyqeVJSCG2NBTCci3q2rQLi+8SQ/C+qIbr/V
	 nMYnFWhCpUMB0ekmRFi6F46X+Y+HMgvNyNJ7OHUVQWb3X6IhhPqNNCpSSi0YhOLbmN
	 WYX7nWtUQ8fsQ==
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhost.u-ga.fr (Postfix) with ESMTP id C137460066;
	Wed, 27 Oct 2021 19:31:09 +0200 (CEST)
Received: from [192.168.1.50] (lfbn-lyo-1-263-125.w2-7.abo.wanadoo.fr [2.7.103.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 9CD0F40063;
	Wed, 27 Oct 2021 19:31:09 +0200 (CEST)
Message-ID: <3ae7f966-1f4a-6a72-dfb9-c899999a7c6b@univ-grenoble-alpes.fr>
Date: Wed, 27 Oct 2021 19:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: fr
To: Mansour Moufid <mansourmoufid@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110270723001.2966@hadrien>
 <CALogXGWiB_XwOZ5MsQe2qKu8ESDMYfRqTYg24ALZQF=sxkSi5A@mail.gmail.com>
 <alpine.DEB.2.22.394.2110271745200.2966@hadrien>
 <CALogXGVkE1V_9Whf6ZEYJf4k+3RSA-tYH8nxCP3c2E3_DESuvQ@mail.gmail.com>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <CALogXGVkE1V_9Whf6ZEYJf4k+3RSA-tYH8nxCP3c2E3_DESuvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (40)
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 195.83.24.62
Subject: Re: [cocci] Feature request: print status messages to the terminal
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 45
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/3ae7f966-1f4a-6a72-dfb9-c899999a7c6b%40univ-grenoble-alpes.fr>

Hi,

On 27/10/2021 18:18, Mansour Moufid wrote:
> On Wed, Oct 27, 2021 at 11:46 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>> --verbose-status ?
> 
> Sounds good to me. :)
> 

For the record.

ctermid is in the extunix library.

module U = ExtUnix.Specific

let _ =
         let tty = U.ctermid () in
         Printf.printf "%s\n"  tty;
         let tty_ch = open_out tty in
         output_string tty_ch "Hello\n";
         close_out tty_ch

$ dune exec ./ctermid.exe
Hello
/dev/tty

$ dune exec ./ctermid.exe > /dev/null
Hello


-- 
Nicolas Palix
