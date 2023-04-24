Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A9C7618E
	for <cocci@archiver.kernel.org>; Mon, 24 Apr 2023 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=k/rfWM0RtyL63BGAVVyttbTYtoO69ClGBYoiip9R1vk=;
  b=h3Ch2uHmK7D8cPvv8Fqi2rVd31QhzI0qV+YEeuI046dqzaO1OQWrXi5e
   iMYC33SkOW2x3PI8MSuYHYg7ztGnwLIn8X3lIuTfFDA8f57oCnYLfAF/1
   fNvhvpV14UdEhJ5Hb//nqeXef2JS5sNPy837cGgps2bl7SfQuhmXpWdTs
   0=;
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
X-IronPort-AV: E=Sophos;i="5.99,223,1677538800"; 
   d="scan'208";a="104728853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2023 16:57:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B575E0269; Mon, 24 Apr 2023 16:57:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 99EAFE019E
	for <cocci@sympa.inria.fr>; Mon, 24 Apr 2023 16:57:25 +0200 (CEST)
IronPort-SDR: 644698c5_ltHvd/xPp/SESflaHHN3of0ZPuztoJ44RANGXcjJlIiR2iq
 agUcGvVBwQGB+268msYtn8J0+qW8Q4SqjNJHl3A==
X-IPAS-Result: =?us-ascii?q?A0EyAABUmEZkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYkXA4Qwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSCC4FggQoKAoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICRz4BAgIBIwQZAQERJgEECwsaAh8HAgJXBgEMBgIBAYJ6g?=
 =?us-ascii?q?igBAw4jB60xfzOBAYIIAQEGnA0fLCJUgV4JgRQtAY0fgzd6Jw+BVUSBPIMEP?=
 =?us-ascii?q?oREg1uCZ410iBuBM3SBJ4ExgQQCCQIRa4EQCGWBc0ACDWQLDnCBRV9GgXIEA?=
 =?us-ascii?q?hQ0DgwXBUIlBA4DGSsdQAIBCzs6PTUGAwsfBkQCHxGBWQQvWncKBgElJJcLc?=
 =?us-ascii?q?1KBB4IdDZI7sQQ0B4IrgVaBWQyfDQYTL5cJDgaSJS6HMpAYIKgAgWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIBkeg26PCQE+PzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:tyVaxa8YhxoX/E8StJJuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:ZbPKBGHAK6mb/UNVqmJY92o+PJA4YkaM6yqICRe8Sm1uGIOaHAo=
X-Talos-MUID: 9a23:AhkjPAunJxo03UxsDc2ngGFDMsdS+K2SN1lTzbECpc6PJAgtJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,223,1677538800"; 
   d="scan'208";a="104728790"
X-MGA-submission: =?us-ascii?q?MDGUHAMjMJkqPz35SX9mSGp6Gpci5Wkpe250Yd?=
 =?us-ascii?q?OQIhALFF6L6GIUqXP3b2hD2VVE2kJTPd8zDwSSqdBwbs0oxKOeBkdv0P?=
 =?us-ascii?q?HwRlxtsu5EacHwVAI86b2cgw2GLTrJjdDpQM07neZPQskJZyPupbU6oA?=
 =?us-ascii?q?l4aKJ43UZV2ZCtwxvguk2FVQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682348198; i=markus.elfring@web.de;
	bh=jtkDVmdLDFIKgsp0YNlPgC/wM/63IRAQqD09QHNqHT8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KnkvuDUvyAkbuyl7wtmk4a68ZnRcbYjRrIvKdbHQvyZcLiHFMoS2GawCu4XkeI+Ie
	 FWfoLGh6P5/867/Jg3BFC6y3LKNF4NfcxqEd8CX0TxvYppRiwGsJpcxaQhhOj0hzog
	 bYWe3Pcy3DP5MiTy/+Uo7XlabkIZnoMhvIIuGCUFNo06/cA5vJyP7kulZPMdWzwyzG
	 4nZsB4ZbNcKd2F+JpIY9/7iCKv2MpcYabWatVWcNM3IlItvNlhOoaYRE/EyUEeGyUo
	 TmeRGfuniq2/mQcbm0ZV32CDSm8U3/soh/DL7mYiNsG9ws7PbLeO56fFZNSvI6l8N7
	 l0japGPM7iCDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1qVE7d2ueV-00hS8E; Mon, 24
 Apr 2023 16:56:38 +0200
Message-ID: <801aecdc-72ba-b3eb-dc7f-4399c088c60c@web.de>
Date: Mon, 24 Apr 2023 16:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <c18331ca-3de9-d433-f477-b04103958b9c@web.de>
 <fbdee94e-b731-0471-e18f-b334ab0db7f5@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fbdee94e-b731-0471-e18f-b334ab0db7f5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UnK0rUvKC1Pk9JiB/V5fR4RvTmP+1z/CDc0w5EEuY+1RjWp/iAA
 Z+/Kb0zUbJCD4z2hceZ2Iv939MQ/AMp009ywOEcPdRAUWtFdPeUlVTkKHRrPJ4ehzLq2YuK
 W3qsniM0IDjgO9uBOwsApR99ytwVLDXvRYzLIihdkFu9bRzoxECOsvIlAJar47Qz07kg80f
 ymL7nBdXdMku73Xz6L0hw==
UI-OutboundReport: notjunk:1;M01:P0:oHWKBFsbJOQ=;Q+gxQQVOZ2AbqV/7gri2YaNHHOy
 +uLrThMcG2eiORJuV8TXWo9nOFa7+VNPb7Fd9P5y/+Tl/SSmvzgvQtl3TYrmmXPXkc08RafSa
 s5PXXLaJRxyMP4NC2w0yV1SZvwDhZ9xpB3otj+aaLqmCYTmtNKQcJOfvYTZAFxUGkOD/x7cI1
 NT0XeBWXRvOPVswgGqVok8a91hkXOZwGjZkUknPOkUkgTP3D5J3I/oDP8hc391kCn0UXoRkzh
 YavFMLbbVnd47PpXQaCDuogJXG+t2bSmFk5Z/zPPsmB2ulLa6l/tl1NM5OR/5yeyuW1ki4FWY
 V6yaRqDqW/X39UQtIyyOYRPWwhSfJ6sniC9ibZ45D9N1vWxbRX/h8oXNG5nZN0kzVNVUxLHZA
 XCKXKoF9uQcN5sYHHCG9gbFGpktihlkTIYO8Xwny1AJD+MAAoQvhIyDn3kh1Bob52wjrNZeAG
 I/AKEbro2jn9Mr9ePx2NQOC/fkTCH7rF+omnZJsiZCk6/BkI4/k8ztATaFlzgEPDGSSPGL0xD
 rJFXtxh8e3kFb9sB3BTpzbwZkBdJZ3Jm9+T63edL4L7TK99tJQWEMN9JuYsjf0Nl0Qxfl4dFY
 /NsBq2/mFjL/BwKaK9gVUqVhno5pVnwaU83fifwcl/uIoQQI3sEOkz2r+ICEGXl6v1yp5iNEs
 1ZdHWKog8IQIlTnNPhXwuGPpVgHprAY1aPeR41meMzzbP/RoAGiHI87de7lwaAQyWiNmsb4r1
 9Ty8jGOfWLQZi87DyzjrDtrW2/FxWPEaQmKEzBlx1byehSIJ9RFIdYmRgg4IqN3AKKTv/Cr7I
 fBccbbHPyiBtEX5wSCVfCBnIDmjjlBugrvUewpGkDYu9ZKq6qtx7sms7H6hYeG/tnKMQsm8FZ
 z2cg5J5WgwfwZjRO2U3JlfFVe6Akdj4INPkXD69x7lRjJZgPbrWPUfVJ1bPFcchxh4iSHyuXV
 2x8PXQ==
Subject: Re: [cocci] [PATCH] ASoC: SOF: Intel: hda-stream: Move three
 variable assignments behind condition checks in
 hda_dsp_iccmax_stream_hw_params()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1127
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/801aecdc-72ba-b3eb-dc7f-4399c088c60c%40web.de>

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Chda_dsp_iccmax_stream_hw_params=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by moving the assignment
>> for three local variables behind some condition checks.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 7d88b9608142f95ccdd3dfb190da4a5faddb1cc7 ("ASoC: SOF: Intel: hda=
c_ext_stream: consistent prefixes for variables/members")
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Yes indeed, for some reason this was fixed in
> hda_dsp_stream_hw_params() but not in the
> hda_dsp_iccmax_stream_hw_params() variant.

Would Peter Ujfalusi like to support similar source code adjustments
also according to his commit 09255c7ed8ca1f1ed99357b845d2f63fe2ef3e1e
("ASoC: SOF: Intel: hda-stream: Do not dereference hstream until it is saf=
e")
from 2023-04-04?


> Could we however use the same code as in hda_dsp_stream_hw_params() for =
consistency?
=E2=80=A6
> 	hstream =3D &hext_stream->hstream;
> 	sd_offset =3D SOF_STREAM_SD_OFFSET(hstream);
> 	mask =3D BIT(hstream->index);

Can it matter to move such assignment statements a bit closer to subsequen=
t statements?

Regards,
Markus
