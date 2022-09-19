Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D27C54EE9
	for <cocci@archiver.kernel.org>; Mon, 19 Sep 2022 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C489eacv+Y/I5B6V9dF4nFV/S/IjFPcTL3UGXEmd5dE=;
  b=TSdijfSt8hyIVbnPTv8+IHwSgpmFeN9m63L15o2oA8WbZOewrDamUkst
   MM+cwjTpWHEzii45pm93IPed2M7nbH8lQ+kxaB9ZCedGGnbDT9BPGpAHn
   G8xePRON5f0pKi4eFaozY/8MzBrH9WYJe9VEcwBk28g+Jx5WjymxF8e1H
   k=;
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
X-IronPort-AV: E=Sophos;i="5.93,327,1654552800"; 
   d="scan'208";a="53369056"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Sep 2022 10:01:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D16CE039B; Mon, 19 Sep 2022 10:01:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E4890E0157
	for <cocci@sympa.inria.fr>; Mon, 19 Sep 2022 09:55:36 +0200 (CEST)
IronPort-SDR: 63282078_lvKj64lpqD5YoaUCxZ/3fD7ngFaqceFiDNfCIk0NlRapElm
 rkKz/tCf0mSmlr/4o9V3LUQcMafyTJ/Bkxd3lOQ==
X-IPAS-Result: =?us-ascii?q?A0ALAAB9HyhjmLzU+S1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIjgVYvBAtFF4Q3iB+IRy4DhCaTFYVVFIFoCwEDAQwBQgQBAYUFA?=
 =?us-ascii?q?oRqAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBA?=
 =?us-ascii?q?QEBAQEUCRkFDhAFIoV1gjUpAYNjAQEBAQIBIwQLAQVBBQsJAhgCAiYCAlcGD?=
 =?us-ascii?q?QEFAgEBgnmCfiMDjyGbHXp/MoEBiB2BZYERLAGIRoMhglmBYyccgUlEgRUng?=
 =?us-ascii?q?RVtgQE+hAeEE4JmBIEKkSuCTYNgHCYEDgMaKx1BAgELQjQYAxQDBSQHAxkPI?=
 =?us-ascii?q?w0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk04CAQIBCskDwUCBy8FBC8CHgQFB?=
 =?us-ascii?q?hEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQVZEAkhHAoEGg0FBhMDIG8FCjsPK?=
 =?us-ascii?q?DJrKx0bCoEMKigVAwQEAwIGEwMDIgIQKjEUBCkTEi0HK3MJAgMiZwUDAwQMH?=
 =?us-ascii?q?iwDCSEfBygmPAdYOgEEAwMQIj0GAwkDAiQTSHk3ExUFAw0ZJggFIxYdBAg8A?=
 =?us-ascii?q?gUGmmMHgQ4Bf3FaHguST449ghKdKIE1g2CBRwyeSwYPBC6We5IJLYcJE49Bm?=
 =?us-ascii?q?SWJFoUBAgQCBAUCFoFhOoFbMxoIGxWDIk4DFwIPjiwNCY47NzE7AgYBCgEBA?=
 =?us-ascii?q?wmGR4MdgRIBAQ?=
IronPort-PHdr: A9a23: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
 ooBQ+cBEV0zUPMHA1toHZoJJ5IlBlsZ
IronPort-Data: A9a23:1+vvmqoj3dhHHwMaWarqbDxA9h9eBmI7YRIvgKrLsJaIsI4StFCzt
 garIBnTaf2PZ2KneYgiPNvkp0wAvpDVxtE1SlNuqX1nQy9E8uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHgZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGj9SuvnrRC9H5qyo4mtJ5w1mPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEmut2VUQSE5Qkq6UsHDli2
 8MXMj1dcUXW7w626OrTpuhEndYzI8CzZsYevDdg0DjGAPdgSpfGK0nIzYMFmm1s14YURKyYP
 ppJAdZsREyojxlnK0oeDpk3ms+om3Dgfjweo1WQzUYyyzKPlFAsjei3WDbTUufRSecSnGaln
 TjLoD7GHz4bJNqV6jXQpxpAgceVwH+nBttDfFGizdZhh1aYx0QIGRgOXB26p+O4gwiwQbp3L
 0UL8y4qhboz8UaxR5/8WQe5qTiKpHYht8F4CP8q5wjVkO/V5UCZG2EbQz8HY9sj3CMredA0/
 gaXh4rsIRJ2jOzWEm/F2pmroim/aTdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJszHlJd3j6
 2vW83dl3d3/meZSjv7kpwqf6965jsGRFlZd2+nBYo6yxihfDLNJiqSz+0jU5K4aaYefCFmct
 WcJmo6V6+Vm4XCxeM6lH7tl8FKBvazt3NjgbbhHQ8lJG9OFpyHLQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp0lvW6SIS5Cq2PMLKih6SdkifaoUmCgmbNgwjQfLUEy/lja
 f93j+71Vh729piLPBLsGrtBj+Z6rszP7WPOTI/2zly73LGeYnmRTrgEPUDGZed/hJ5oUy2Lm
 +uzw/Cikk0FOMWnO3G/2ddKcTgicCZnbbir9Z0/XrDYeGJORjp+Y8I9NJt8IeSJaYwPyLeRl
 px8M2cFoGfCaYrvcFrWNiE9NeizAP6SbxsTZEQRALph4FB7Ca7H0UvVX8dfkWAPpLMzn81nB
 eIIYduBCflpQzHKsWZVJ5rkoYAoMFzhiQuSNmD3KHIybrxxdTzvo9XERwrI8DVRLyyVscBln
 aas+DmGSrU+RiNjLv3sVtSR832Ls0MwotlCB3nzHoELeWHH0pRbFCjqv/pmf+AOMUriwxWZ5
 Sa3ADAZh+7BnKFuwubKmJHe/puIEvR/LGVeDWL0/ba7DgiE32uBkKtrcveEQiDZb0zwoJ6dX
 ORyy+rtFsEHkHJhkZtOI5wywY0Qv9LQ9qJnlCJ6F3D1XnGXI7JHIEje+/JQt6dIl4RriSHvV
 m2hotBlaKi0YuX7G1ssJS0gXOSJ9dcQvhLwtf0VAkHL1BVbzYq9c3d5Hkez0XRGDb5PLoka7
 /8ru5cW5yyBmxMaCIu6oR4OxVucDE4rcvsBhskBDZ7Jmzgb7AhIQabhBx/c5LCNbNRxMXcWH
 AKEuZqah5pg6xrDV1ERCUny2fFsgMVSmRJSk34HCVe7uvvEof4VzhBX8TIGci1E6ipDzsZ2O
 jFaB0FxLJ7T/T0y3MlndEKvEjFnGxe21BHQyVwItWuBVGiudDXHA1McMNa33nIy0jxjbB1E2
 rCH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wupaYb76B380g53GpBpTjZ/g3CzfhmgqftZQrfgAO
 r7hLwylLGjBqkZXyknsrdZFMFWWedMrRhPx98Hr/fQrF6AsivBNc0Yz25uKv3nPDhND+jSKt
 jjifI7T9fRpkq53rrvvE4JCJgS6EszyX+K26zKOs8xCQNfMEMXWvSYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJm/bR8XEpOQ7ksBpJjO1bsVJc3b9C753HSEmCshUjEobf40wYp7TbQEHSfDcLm+
 tT/SwPjcAip8rT9pD2DX1eeYjVMZJq8vQUxQq7Z08Vkmz+zVDRDLOJbMYgPFZxV1Cf10fkUo
 d0LgHQKUU3AsfZsKH0QI+gPmi+fG+URN9a/LTssl69RQznjH5uOWdON6Q85i0qbuVLfICWPK
 cwX5XDxeBO2x/mFgArVCuOT2Y9a+x8R+p7EFY0RXSA/79byzIjmDEBcITc=
IronPort-HdrOrdr: A9a23:5h5qDKNfFRlJU8BcTvWjsMiBIKoaSvp037Eqv3oBKiC9Ffbo8f
 xG/c5rsiMc5wx8ZJhNo6HkBEDEewK5yXcX2+Ys1NWZMTUO0VHAROoJ0WKh+UyDJ8SUzI9gPM
 lbE5SWROefMbCn5fyKmzVRRL0bsaG6GfeT9J7j80s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,327,1654552800"; 
   d="scan'208";a="24045582"
X-MGA-submission: =?us-ascii?q?MDFQrbLuwHo/uGij9JntFDxOWdgSKjCAZxNbox?=
 =?us-ascii?q?gxdQ/DLdxhyV1aMc+bOSlYMl3tAZ04LGt7gtRR9Yq6YR31c0Dc2Qa0to?=
 =?us-ascii?q?t92laurVDumXPhOVuYIbeX7DiiFGXIFtKtChw621zj+Ux9CCV1m0Yqlc?=
 =?us-ascii?q?h4v0EsTAv41+NM4aCWuFJjMg=3D=3D?=
Received: from szxga02-in.huawei.com ([45.249.212.188])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:55:35 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWH1h6BBZzmVNX;
	Mon, 19 Sep 2022 15:51:36 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 15:55:29 +0800
Message-ID: <f246dc0d-d4f2-e93e-d5c1-d7a6711d14e1@huawei.com>
Date: Mon, 19 Sep 2022 15:55:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Julia Lawall <julia.lawall@inria.fr>
CC: <nicolas.palix@imag.fr>, <cocci@inria.fr>
References: <20220916061923.29759-1-yuancan@huawei.com>
 <alpine.DEB.2.22.394.2209182132260.3003@hadrien>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2209182132260.3003@hadrien>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 556
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/f246dc0d-d4f2-e93e-d5c1-d7a6711d14e1%40huawei.com>


在 2022/9/19 3:39, Julia Lawall 写道:
> On Fri, 16 Sep 2022, Yuan Can wrote:
>
>> Find mutex used without init, and point out the
>> place the mutex is allocated.
> Thank for the semantic patches.
>
> Traditionally, the semantic patches in the Linux kernel have a Confidence:
> tag above the Coyright: line.  I would suggest to put such a line in this
> case, based on your experience.  From looking at a few results with the
> mutex semantic patch (I didn't get any results with the spin lock semantic
> patch, is that normal?), I would suggest a Low confidence.  The cases I

Thanks for your suggestion, I will add Confidence tag in the v2 patch.

About the spin lock semantic, by excuting "make coccicheck 
COCCI=scripts/coccinelle/locks/missing_spin_lock_init.cocci MODE=report",

I get the following output:

12419 files match
./drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:1851:1-4: Spin lock 
inside the struct malloced here is possibly used without init.
./drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:1180:1-4: Spin lock 
inside the struct malloced here is possibly used without init.
./fs/ext4/super.c:4292:1-4: Spin lock inside the struct malloced here is 
possibly used without init.
./drivers/net/wan/fsl_ucc_hdlc.c:1172:1-11: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/usb/cdns3/cdnsp-pci.c:95:2-7: Spin lock inside the struct 
malloced here is possibly used without init.
./fs/cifs/smb2pdu.c:3854:1-5: Spin lock inside the struct malloced here 
is possibly used without init.
./drivers/net/ethernet/broadcom/bnxt/bnxt.c:7618:2-5: Spin lock inside 
the struct malloced here is possibly used without init.
./drivers/clk/x86/clk-cgu.c:592:2-6: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/clk/x86/clk-cgu.c:228:1-4: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/clk/x86/clk-cgu.c:346:1-5: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/clk/x86/clk-cgu.c:103:1-4: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/gpu/drm/amd/amdkfd/kfd_device.c:426:1-4: Spin lock inside the 
struct malloced here is possibly used without init.
./drivers/clk/x86/clk-cgu-pll.c:119:1-4: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/scsi/aacraid/dpcsup.c:187:7-10: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/scsi/aacraid/dpcsup.c:287:9-12: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/usb/cdns3/cdns3-plat.c:60:1-5: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/media/platform/renesas/vsp1/vsp1_video.c:667:2-6: Spin lock 
inside the struct malloced here is possibly used without init.
./drivers/net/wireless/marvell/mwifiex/main.c:83:2-18: Spin lock inside 
the struct malloced here is possibly used without init.
./drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:1268:1-14: Spin lock 
inside the struct malloced here is possibly used without init.
./drivers/mtd/ubi/build.c:896:1-4: Spin lock inside the struct malloced 
here is possibly used without init.
./drivers/misc/cxl/guest.c:1110:7-21: Spin lock inside the struct 
malloced here is possibly used without init.
./drivers/vfio/pci/mlx5/main.c:607:1-6: Spin lock inside the struct 
malloced here is possibly used without init.

> looked at seemed to involve calls across different files, and Coccinelle
> is looking at only one file at a time.
>
> I would also suggest to print out more information, to help the user
> better undestand where the problem may be.  Specifically, it would be nice
> to have the name of the lock field, the position of the declaration of
> this field, and the position of the call to mutex_lock.  You already have
> the relevant metavariables in r3, and can add a position metavariable in
> r4.

Agreed, but how could I fetch the name of the lock field? I cannot find 
a doc describes how

to achieve this(or did I miss it?).

>
> Finally, you have a * at the beginning of the matched line in r5, so the
> rule seems to support the context mode.  But if you want to support the
> context mode and to highlight all of the mentioned places, you would have
> to duplicate r3 and r4 with a depends on for r5, so that the context is
> only shown when all of the conditions are satisfied.  For example, you
> could have:
>
> @dupr3 depends on r5@
> identifier s, fld;
> position r3.p;
> @@
>
> struct s {
>    ...
> * struct mutex fld@p;
>    ...
> };
Ok, thanks for the explanation.
>
> Are there some patches in the Linux kernel that are based on these rules?

Yes, there are many patches based on the two rules.

Best regards,

Yuan Can

>
> thanks,
> julia
>
>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>> ---
>>   .../coccinelle/locks/missing_mutex_init.cocci | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci
>>
>> diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci b/scripts/coccinelle/locks/missing_mutex_init.cocci
>> new file mode 100644
>> index 000000000000..bec8ce60d0c5
>> --- /dev/null
>> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/// report missing mutex_init()
>> +///
>> +/// Report mutex used without initialize. False positives can occur
>> +/// when the mutex allocation and initialization happens in two
>> +/// different files.
>> +///
>> +// Copyright: (C) 2022 Huawei Technologies Co, Ltd.
>> +// Comments:
>> +// Options: --include-headers
>> +
>> +virtual org
>> +virtual report
>> +
>> +@r1@
>> +identifier s, fld;
>> +struct s *mm;
>> +@@
>> +mutex_init(\(&mm->fld\|&(mm->fld)\))
>> +
>> +@r2@
>> +identifier r1.s, r1.fld;
>> +position p;
>> +@@
>> +
>> +struct s {
>> +  ...
>> +  struct mutex fld@p;
>> +  ...
>> +};
>> +
>> +@r3@
>> +identifier s, fld;
>> +position p != {r2.p};
>> +@@
>> +
>> +struct s {
>> +  ...
>> +  struct mutex fld@p;
>> +  ...
>> +};
>> +
>> +@r4@
>> +identifier r3.fld;
>> +identifier r3.s;
>> +struct s *mm;
>> +@@
>> +
>> +mutex_lock(&mm->fld)
>> +
>> +@r5 depends on r4@
>> +identifier r3.s;
>> +struct s *mm;
>> +position p;
>> +@@
>> +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>> +
>> +@script:python depends on org@
>> +p << r5.p;
>> +@@
>> +cocci.print_main("Mutex inside the struct malloced here is possibly used without init.", p)
>> +
>> +@script:python depends on report@
>> +p << r5.p;
>> +@@
>> +
>> +msg = "Mutex inside the struct malloced here is possibly used without init."
>> +coccilib.report.print_report(p[0], msg)
>> --
>> 2.17.1
>>
>>
