Return-Path: <SRS0=L9f+=PJ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAFCC433EF
	for <cocci@archiver.kernel.org>; Thu, 21 Oct 2021 07:08:38 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00F060F5D
	for <cocci@archiver.kernel.org>; Thu, 21 Oct 2021 07:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A00F060F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="396610960"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail3-relais-sop.national.inria.fr with ESMTP; 21 Oct 2021 09:08:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 218EFE0019; Thu, 21 Oct 2021 09:08:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BAEAEE0018
	for <cocci@sympa.inria.fr>; Thu, 21 Oct 2021 09:08:32 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=joe@perches.com; spf=None smtp.mailfrom=joe@perches.com; spf=None smtp.helo=postmaster@smtprelay.hostedemail.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AhZ3tEhzakecsi5nXCzJezVBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhSZtKwm0QCBdL6YwsoMs/DRvaHkVD5Iyre6m1dGTqZxUQQYg?=
 =?us-ascii?q?94dhQ0qDZ3NI0T6KPn3c35yR5waBxdq8H6hLEdaBtv1aUHMrX2u9z4SHQj0ORZ?=
 =?us-ascii?q?oKujvFYPekdi72/q29pHObAlFhDiwaq5uIRurqgncqtMYipZ4JKYrzRvJrHpIe?=
 =?us-ascii?q?+BIym5tOFmegRXy6Nqu8ZB66yhftO4v+MBGUaXhYqQ3VqdYAyg8M2A0/8Lkqx/?=
 =?us-ascii?q?ORhaS63QGU2UWlh1IAxXZ7Bz/Q5z8vDf2uvZ71SKHJsD9U6w6Viq+4KdqUB/oi?=
 =?us-ascii?q?TkINzgl8GHMl8d8iLtXrA+9qxBjxoLZZpyeOvhjcaPHZd4URndPUMZPWSJPAIy?=
 =?us-ascii?q?8YZcAAOQOMuhXtIT9u1kDoAGiCQWwHu7j1zlFjWL2060g1OQhFBnL0ggnH90Qr?=
 =?us-ascii?q?X/atsv6NL0OXuC10qbI1ijIYvRU2Tf69ofFaQghru+WXb1sccre11IvGxnZgVW?=
 =?us-ascii?q?XrIzoJjWY3fkCvGaH9eRvT/6vi3I5pAFrpDii3sMhh4bVio8VxV3J+zh1zoYoK?=
 =?us-ascii?q?NC6VEJ2Y8KpHIZMuiyaNYZ6X8wsTm9ntSg0ybAItpy2cSYOxZg5xxDRZOCLfpa?=
 =?us-ascii?q?O7xn+V+iROS91iGx4dL++nRq//lSsxvfzW8S7ylpHqiVInsHSunwQ1hHf8MeKR?=
 =?us-ascii?q?udn8kqv2juDzQHe5v1CLEspj6TUMYQhzaQ1lpcLsUTMACv2mELuga+Nc0Uk5vC?=
 =?us-ascii?q?o6/75bbXivJCdN5V4igH5MqQ1hsywH/k3PRYLX2eB+OS80Kfv8lH+QLVPlvE2k?=
 =?us-ascii?q?6/Zv47GJckDuKK1Hg5Y3pws5hqjFTur39sVkWMDIV9KYB6HipLmO1DKIPD2F/e?=
 =?us-ascii?q?/hFGsnS9px/DBILLsGY3NIWbZkLj9fbZy9VVcxBAvwtBY4pJYEqsBL+7rWk/tq?=
 =?us-ascii?q?NzYCQc0MwOxw+b6DNV90p0RWXiUD66YMaPStESH5vg1LOWWZY8Vviz9K/k/6PL?=
 =?us-ascii?q?0g385g0cXfbO10psPdHC4AvNmLl2dYXX2jNYOC2MKvg4lQe3riV2CVCVcZ2yoU?=
 =?us-ascii?q?K4m5zE7DpimDYbZSYy3jryBxj+xHodKaWBeFlCMDXDoep2YVPcLdC2dPs5hnyc?=
 =?us-ascii?q?fVbmhTo8hzQuhuBX7y7phNOrU+zcXuYjt1NhvtKXvkkQ5+jFwSdaB3kmCSmh1m?=
 =?us-ascii?q?iUDQDpylKVkvWRnx1uD2LQ+iPtdUZR/6vVISU8XO4TRyutkQ4T/VBjMe9CXYFK?=
 =?us-ascii?q?nRMi2Rzo2S4R1i/0TZ0d0U/GrkRnH22L+IaIRlrXNIJUr+6bY93n3Pcd0jXjcg?=
 =?us-ascii?q?u1poFgiRsZUfUi7gqpy7UCHKI/Nl0iC0YO3caARxgbM8n2CxCyAphccGChxWqL?=
 =?us-ascii?q?BVGtXXkLSrMSxskXDRLiqAK9hKgJFyN6qK65DZZvnlwMCDNLiM9TXZyqUkn29B?=
 =?us-ascii?q?l7cw7KHbIPuPWEe2SH1DUEekAcN/DCAOBRoQm+qpGnVDRRvE0juagXi67pQsnS?=
 =?us-ascii?q?+G20zwkmyYldq17euskoXgvG0U/4J1bIJo2EqrDAiTwX15M7fF9fV/1kpR65be?=
 =?us-ascii?q?95opQ4fjQoxUiRlM4arL615wFUZdlYv16sP/w5yFp1anMwjvTUqyxFuJK6V1Vp?=
 =?us-ascii?q?Ac3WT2pWiYtU/xUHq8Qqka6PNnFrZ1YTOkpo=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3As8oEDqrs78jVC2jUyjn3Y14aV5oWeYIsimQD?=
 =?us-ascii?q?101hICG8Sqej5qKTdZUgtSMc7Qx7Mk3I9urwX5VoPkmsk6KdjbN9AV7AZmjbUQ?=
 =?us-ascii?q?mTQ72KhLGKqwEIcBeRygcy78tdm48UMqySMbBA5vyKhTVRKr0bsb26GamT9J7j?=
 =?us-ascii?q?80s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DNAAASaxphmF4sKNhaHQEBPAEFBQECA?=
 =?us-ascii?q?QkBFYFZAoN3KBIxjUuIAmqBPYkekQ2BfAsBAwENEi8EAQGEYQKCbB4GBjAJDgE?=
 =?us-ascii?q?CBBUBAQUBAQECAQMDBAETAQEBAQEBAQEJCxAGOiSFdYI1KQGDYwEBAQEDeRALF?=
 =?us-ascii?q?QMcEiE2BgESgnGCVgMvBaZ8eIEzgQGEaYJcDWWBY4E6AYl4g3pDP4FOhDo+giC?=
 =?us-ascii?q?CJIV7BIN0pAgBX5w9XoMygTeXNoYQpnWWEY90kFiEeQGBX4IUTSMVgyRQGQ6OO?=
 =?us-ascii?q?Y16AVwhMjgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0DNAAASaxphmF4sKNhaHQEBPAEFBQECAQkBFYFZAoN3KBI?=
 =?us-ascii?q?xjUuIAmqBPYkekQ2BfAsBAwENEi8EAQGEYQKCbB4GBjAJDgECBBUBAQUBAQECA?=
 =?us-ascii?q?QMDBAETAQEBAQEBAQEJCxAGOiSFdYI1KQGDYwEBAQEDeRALFQMcEiE2BgESgnG?=
 =?us-ascii?q?CVgMvBaZ8eIEzgQGEaYJcDWWBY4E6AYl4g3pDP4FOhDo+giCCJIV7BIN0pAgBX?=
 =?us-ascii?q?5w9XoMygTeXNoYQpnWWEY90kFiEeQGBX4IUTSMVgyRQGQ6OOY16AVwhMjgCBgs?=
 =?us-ascii?q?BAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="396610941"
X-MGA-submission: =?us-ascii?q?MDFixgLB2qyh7BykerzI/GSpWjMZP5pGTs8Sd4?=
 =?us-ascii?q?A96u3kdTZxED+JttNVx1hIEvU2XVCY0m15AA2Yyl4pEateW6FNlVjwDZ?=
 =?us-ascii?q?wxw/6AjXn9RG3ondTHTwcsuafU41dVVrfQ4RgRoh3QMmz36+AD64syrw?=
 =?us-ascii?q?P3nme2YT6gqTgPzSZKyK27GQ=3D=3D?=
Received: from smtprelay0094.hostedemail.com (HELO smtprelay.hostedemail.com) ([216.40.44.94])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 09:08:30 +0200
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0533A180E07B8;
	Thu, 21 Oct 2021 07:08:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 95407D1514;
	Thu, 21 Oct 2021 07:08:24 +0000 (UTC)
Message-ID: <b85fee5ff20d2b398948a6bccf1bcc5eb22b49ff.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: cgel.zte@gmail.com, mst@redhat.com, Denis Efremov <efremov@linux.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Gilles Muller
 <Gilles.Muller@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal
 Marek <michal.lkml@markovi.net>, cocci@inria.fr
Cc: jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, 
	axboe@kernel.dk, virtualization@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Ye Guojin
	 <ye.guojin@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Date: Thu, 21 Oct 2021 00:08:23 -0700
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 95407D1514
X-Stat-Signature: w1k1cs1tg45sjhxa5ai68tet591rgwep
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18GuLItoKjGI2brebfiEvCynGxVYaDHZyo=
X-HE-Tag: 1634800104-276374
Subject: Re: [cocci] [PATCH] virtio-blk: fixup coccinelle warnings
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 25
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/b85fee5ff20d2b398948a6bccf1bcc5eb22b49ff.camel%40perches.com>

On Thu, 2021-10-21 at 06:51 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
[]
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
[]
> @@ -624,7 +624,7 @@ cache_type_show(struct device *dev, struct device_attribute *attr, char *buf)
> -	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
> +	return sysfs_emit(buf, "%s\n", virtblk_cache_types[writeback]);

Perhaps scripts/coccinelle/api/device_attr_show.cocci should be updated
to be more like the script used in commit 1c7fd72687d6

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}


