Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E9C761A6
	for <cocci@archiver.kernel.org>; Mon,  3 Apr 2023 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=r9a5FByD+JOgUxBysf+1AQ/Rl1Mljp52NEum8oJrbFI=;
  b=HB3r8BU2P+RRVlf/j55BKIGvoAqnzOMc6cXIvh3zDEH92F486gzL8i8c
   3ptpg1F49H8hBwAShNuDYiSegMXHOQrH+gx+ctFvKGYNBt0bbYmvrYaFh
   iCMSS9HEsu5t4PcE2S6rllLmB95tfoMUwdvGpRtgNkPnFpytr9IqbYQi9
   U=;
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
X-IronPort-AV: E=Sophos;i="5.98,314,1673910000"; 
   d="scan'208";a="100447032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2023 14:50:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B3493E01D1; Mon,  3 Apr 2023 14:50:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8F4ABE00CE
	for <cocci@sympa.inria.fr>; Mon,  3 Apr 2023 14:50:36 +0200 (CEST)
IronPort-SDR: 642acb9b_Y9KAXp+cyVkQ2F0oNUL68cXl7zbI9CX8/tT7n257O/3epkm
 InVq7M11x3NIF5LhDlVPJKruJTMFdOHPL5N3PlQ==
X-IPAS-Result: =?us-ascii?q?A0GyAACxyipkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItdVYvBAtGCCKEKZEBMWmDRpdWgxY+DwEDAQ09BAECBAEBAwEDO?=
 =?us-ascii?q?IERgnBGAmuEUQIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERVg6BBgIBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICDToYOz0BAgIBIwQZAQERJgEPCxoCJgICVwYBDAgBAYJ6AYInA?=
 =?us-ascii?q?QMOIwcMBqlGfzOBAYIIAQEGnAofLCJUgV4DBoEULQGNB4M2eicPgVVEgRUnD?=
 =?us-ascii?q?IJHMD4egi0XBBiBRoNbgmeOLYsuCoE0dYEgDoE9gQQCCQIRa4EQCGaBe0ACD?=
 =?us-ascii?q?WQLDm+BSmNLgUclBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcEC?=
 =?us-ascii?q?DgGHDQRAggPEg8GJkQOQjc0EwZcASkLDhEDTYFHBC9cfAoGASYknQOBbj+CB?=
 =?us-ascii?q?GLDFDQHgiqBVYFZDIoNlQAGEAMulwkOBpIll3AgjTOaSYF5JIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAMDQmDUDOEYYpnPzQCAQE4AgcLAQEDCYVGAQGFfAEB?=
IronPort-PHdr: A9a23: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
 7IRR7UdWFFnT5vy72x6EdZELJolBlsZ
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:xSY576tmO8uY9JK7Ts1fHN1f7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,314,1673910000"; 
   d="scan'208";a="52014282"
X-MGA-submission: =?us-ascii?q?MDFRdXvXXI4rx5rIWcogJ8XtWhAJNCTe6kVARx?=
 =?us-ascii?q?HH/n6/F5Z1UFZnlT+r6aGnmC386xh0Ty7HKuTdUeg1xOT0sLS46nsAIz?=
 =?us-ascii?q?NJHR877f8xBa/Q8b/rDJT135L+8LrbJI1tJoxVlZGDmEJ1cxwoNDwmmc?=
 =?us-ascii?q?HgR3Ev5px7xQWyv14Mjn7x9g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680526234; i=markus.elfring@web.de;
	bh=lrdMIEZbu0oOmh9hYfzFIkd3ce4XkJJULdmOCn/GCxk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lwIGUqSqh7iuQI3Qsk2WuxUwFPbHcrgtyIjkWnynwKc7FZGOWbqQawVzKASE/UFVv
	 zCaRe50QalitaHDsbxs8io8wEhXCYpgf6MJR1fGUNd5657I7sTE40pvXce7h9xakUe
	 XlyobkmBVDDhMLyUNVssP2SlRdecHNr7415eSMjKD1sJ7Jj4uFBlPII0m32/X7BU2y
	 EmZa0So5B/oqHPKHNm08Y+o9B8tOhsrkyw99j8dI+OMTfeZYcdJXjMXb4E3EKE7hNB
	 a1WrDOAcSxU6Vq9cdknjxIui3NFrau8eHPzQClpUV/jc4AZBmgHdPHsuV8GwT6o+hI
	 98u93Gma5VZ6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1qMVwH10hn-00eKbg; Mon, 03
 Apr 2023 14:50:34 +0200
Message-ID: <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
Date: Mon, 3 Apr 2023 14:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDJV5LvjN4WOFHXqV04/iLpZcGB5s6CDrrkNxxfs1X2mag5/dzC
 SM8tLKYAsbJTxutnGZ2HXFsSNYsI3HPuBwp6QuDIg5+hn9VP0bOl1bs4TakXUg06LrGyW2K
 k8r+1oq7m/kgijJz72pqOAf195tCTZxXg277Uvq2xBSY5/NXlJW+anvH2NUMhg2yLFIkhok
 BbrF75oR++ufltFP1znlQ==
UI-OutboundReport: notjunk:1;M01:P0:cBPwFNcZ4M8=;GPt50CG/N97T8ippjbVTU7BYzuk
 lPs7fA8C5LOGnaD6vsyIH5rr8Xj9FCpcf8VKiApB20HsS6Wh11hMSLeVix+o5iav+l+riKASx
 t5jKZW5YCXVbPyhiE5jQYzdfVcHFXApNU/nwZBcOs/+JXVvtYzAfRfNFs4u3l0SzCgheRgo+5
 Xj7uwZntfsVjJ1YCdBXy0RNoqlot7ao7QCQp/lxambL3LKp82ammEz0mRISk7mdrQ6Td+WP2E
 jyY6LXq0kLlvBpTn6cNHdV0mHHLPjc3F4SsSz8+BV6sVjos0x37X5tYwvC+wCHOlz0EBJVAkn
 zsFDLgGrovc7Xh9PCA67kG0VnmfB2fXGb53jAIzXU6NQkJSLPjIzvvPVJizL6RRifIaUaeLYg
 VOFiNwu4m/94ff5Zi61inJzMtLVdB1ibYLBAKqcWD1VuaZI0sPQ0K1HNo5pP3l9IovJCWa2m1
 wsR2AnQ4oEHzYUk4f/RIc2SUrSb3NCbK9Ny884Lh8BLnY94/O2x+iIju/95ex0PsjSDtAEa9N
 7gFtiUgVsf7E9OAogAfqI3yGpWJbeiZwGtDdhJUHXBOlTgu0V6XMURH8hqehGiMNBwMp39nNx
 lDspzLXqhk/baBMulanXNzSZz1GtBz2NGF4g//jPPW3j8eMx1YBul48n5eekyP5KPDAVltrPh
 2QxK5+RWV8Z48LmIVq7CJHj13iV0XKzYpdXm0mKvAZOu6tTqDCR7lMT6XmEXRrZXskjKkPCGF
 SwUrwxw8Hns90zxh8+DV7WJ+AZETq7klTnIIEV503RE5AER9t8N5mOD7iGEO+JiMjHHPy++rt
 s8Wyh0wuadUX2wOmpkCbkQH5PUxgPmPqf9OOCQR2dQJeRw10Pe6b3UCX8Mx+/05Flrny85QYf
 AP9L4Pdn61Hb6Xf5SNJMRhW0eG3zKLAO92PEDdZ4bhdSKFoRVkUSmUSX/
Subject: Re: [cocci] [PATCH] cpufreq: sparc: Fix exception handling in two
 functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 997
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/39342542-9353-6a7b-0aa9-f9c294b158cb%40web.de>

>> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
>> @@ -324,12 +324,12 @@ static int __init us2e_freq_init(void)
>>  		ret =3D -ENOMEM;
>>  		driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);
>>  		if (!driver)
>> -			goto err_out;
>> +			goto reset_freq_table;
>
> I would just return error from here.

I got the impression from this function implementation that a bit of addit=
ional
resource release would be relevant so far (at the end of a corresponding i=
f branch).
https://elixir.bootlin.com/linux/v6.3-rc5/source/drivers/cpufreq/sparc-us2=
e-cpufreq.c#L309
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/cpufreq/sparc-us2e-cpufreq.c?h=3Dv6.3-rc5#n309


>>  		us2e_freq_table =3D kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
>>  			GFP_KERNEL);
>>  		if (!us2e_freq_table)
>> -			goto err_out;
>> +			goto free_driver;
>>
>>  		driver->init =3D us2e_freq_cpu_init;
>>  		driver->verify =3D cpufreq_generic_frequency_table_verify;
>> @@ -346,11 +346,11 @@ static int __init us2e_freq_init(void)
>>  		return 0;
>>
>>  err_out:
>> -		if (driver) {
>> -			kfree(driver);
>> -			cpufreq_us2e_driver =3D NULL;
>> -		}
>>  		kfree(us2e_freq_table);
>> +free_driver:
>> +		kfree(driver);
>> +		cpufreq_us2e_driver =3D NULL;
>> +reset_freq_table:
>>  		us2e_freq_table =3D NULL;
>
> This wasn't set at this point, no point clearing it here. Also this
> clearing of global variables isn't required at all, as after this
> point no other function shall get called.

Do you see further opportunities for refactoring the source code?

Regards,
Markus
