Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BABAC77B73
	for <cocci@archiver.kernel.org>; Tue,  2 May 2023 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=/J7JPLunsPJvatLYkwauSzoW9MutPTZmYsd8xru59pg=;
  b=b/jF1UiSLkUqhdObUzkHnhliqWdLa0NF7fPF0T1NhhlUXAywoLhzZ3OM
   GMSbakcqYHJvK27aS+tMG6esBHKYoQdb5nbyo7jpcnri7KU0knki9ew1f
   YYTqw8D/64H2RbQCgtM5c8A1CXs53oI2RcJleVjaor5AXGjZrHxGOxU9v
   w=;
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
X-IronPort-AV: E=Sophos;i="5.99,243,1677538800"; 
   d="scan'208";a="105742119"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2023 09:30:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE7A2E0D49; Tue,  2 May 2023 09:30:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 87FDAE0D40
	for <cocci@sympa.inria.fr>; Tue,  2 May 2023 09:30:35 +0200 (CEST)
IronPort-SDR: 6450bc1a_zE9y8N+tLV3XutAMvMzvaDoTYtI2Bl6ylUWUJsjprHvWVKq
 ALp9ySP4EzglVWOwfBuheG3nCxXuhczeM9DHoLA==
X-IPAS-Result: =?us-ascii?q?A0GxDAA9u1Bkhw4P49RagQmBT4IudQNTLwQLRggihCmPE?=
 =?us-ascii?q?YF2LoQzl1eBVoFAPg8BAwENOwYBAgQBAQMBA4FJQoIugTOEVQIdBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoD?=
 =?us-ascii?q?YI3IhlWDoEGAgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgINOmcEGQEBESc0A?=
 =?us-ascii?q?iYCbAgBAYJ6AYInAQMxBwwGrzp/M4EBgggBAQaBQQGBI5koHywiVIFeAwaBF?=
 =?us-ascii?q?C2HUx5eiS0PgVVEgTyCU4NRAgKCK4MOgmeXAWeBMXSBJ4EvgQQCCQIRa4EQC?=
 =?us-ascii?q?GWBdEACDWQLC22BRIMSBAIRQgwUBVgCgQkIFAEYAwcHAgGBDyUEDgMZKx1AA?=
 =?us-ascii?q?gELdT01CQsfBkMCggMEgQl7UJZ/gV45PIECEwErIoFic5JLsFM1B4IrgVYFg?=
 =?us-ascii?q?VUMiG2BIZUABhMvlwoOBpIlHpddjVOVDYVDgWM6gVwzGiRPgmdPAxkPjjmDW?=
 =?us-ascii?q?TOPSD80AgEBOQIHAQoBAQMJhUYBAYUfXgEB?=
IronPort-PHdr: A9a23:peMHCRKU1S7QhcogVNmcuChsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFuLM21gKCBNyLo9t/yMPo8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PTbglSijexf7N/I
 BqroQnMtcQdnJdvJLs2xhbVrXREfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmV
 LJUFDspPXw7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RDqv4
 7t3RBLulSwKMSMy/mPKhcxqlK9VoxyvqBNxzIDKYI+bKeZxcKzGcNMGXGpMRNpdWzBPD46+a
 YYEEuoPPfxfr4n4v1YAqgGxBROvBOPy0T9Dm3D43ak00+Q7EAHG2gMgFM8JvXrTttr1LqQSU
 f2uzKXSwjvDa/1W2S386IjOfRAsuv+NUqxrfsbL1EYgCRrIg1ONooPqIz2bzP4Cs3SH7+V+T
 +KvjXYqph9wrzSx2sohl5XFi4EXx13Y+yt0xJs5KNKlREN4YtOqH5ReujyZOoZqRs4vQ31kt
 DgnxrEbuZO1czUGxZApyRPZdveJfY+I4hf5W+aQJzd1nGlqeLW4hxau9Uigy+v8WtOo31ZNq
 ypJitbMtnER1xzT98iIUeFx8Vum2TaK0Q3Y9+JKIVgsmKbFNpIt3KQ8moQNvUnBBCP6hUX7g
 LWLekgr4uSl7+vqbq/oq5OBLYN5iQHzPr4tl8GxB+kzLxIAUHKB+eum0b3u5U35T6tOjv0xi
 qTZtZfaJdkHpqKjDQ5azJ0s5wyiADi4yNgYnH8HI0xZeB+fkYTlJk/CLOrmAfuhgVmgiipny
 vDcMrH8DZjBNn3Dn63gfbZ55U5c0g0zzdVH6pxTEL4BOvHzWlLqtNDCARE5NwK0w/zmCNV72
 YMTQmyODbGCP6/IrFCH+PojI++Xa4ANojbyN+Al5+LyjX8+gVIRYLGl3YELZ3CgAvRmP0KZb
 GLwjdcGDWgFogs+QffxiFyCVD5Tf2y9U7g95jE9EoKmDJ3MSpqjgLybj2+HGchdYWtNC3iNF
 23pfsOKQaQiciWXd+poiD8ZTvCMT4E71Beh/FvfwqBkM/GS1ykWr5Pl2/Bq6ueVmRxkpm88N
 NiUz2zYFzI8pWgPXTJjhMiXwGR4w1aHiu1jhuBAUMdU/7VPWxs7MpjVy6p7DcrzU0TPZITBU
 06oF/OhBzx5Vdct25kWeU8oPty4jQ3YmQeuDaUUkbOjG5E+tK7RjDDqP8go83/dz+E6ikU+B
 M5GNGmonKl6oi3aHY3UiAO0k6iwdKIT9DHA/iGPwDnGp1lWBSh3V6iNRnUDfg3WoND+s1vFV
 KOrAK87PxFpzMmfNu1VZ9evgVguqO7LHtPYbirxnm6xAU3N3baQdM/xfH1b2izBCU8CmgRV/
 HCcNAF4CD3z62TZRCdjE17ieSaOuaF3tW+7Q0kozgqLc1wp1ry7/QQQjOCdTPVb16wNuSMoo
 TF5VFin2NeeB92FrgtnNKJSBLF1qHJOz2HErEpQOpK6LqZtrkETeUJ7sgKm1hl6DJlBjdl/t
 Gkjn0J5LaOV1k8EdivNh8mqfOeNdS+roVb2N/2zuBmWytud96YR5e5trlziuFrsDU8+6zB81
 MET1XKA55LMBQ5UUJTrU09x+QIpwtOSKiQ7+Y7Q0mVhdKeutTqXkfcgHug40VCNe9lFMaWLP
 BD/GYsWCoL9TY5i00jsdR8CMO1IoeQRNtmlauDA9aqlJudmkxq5gG4B7I03gSfuv2JsD+XP2
 ZgC2fSR2ACKAiz9gFmWucfygYlYZDsWEwJT0ADcDZVKLu13dIcPUiK1JtGvg855n9jrUmJZ8
 1iqAxUH3tWocFycdQ610QpV3EUR6Xup/Enwhxl9iTI0teyy2CLUwuLtXAUKMChHSSFugEztL
 o69k90BFBLxNU5zzkTjvBu8nvQTrb83N2TJREZUYyX6SgMqGrC9sLaPeY8H6Z8ltzlWTPXpZ
 FmbTrDnpB5JmyjnHmZY2HU6b2Tw48+/xUYlzjvAai8v/x+7MYlqyBzS5cLRX6tU1zsCH2xjj
 CXPQ0O7J5+v9MmVkJHKtqa/UXigX9tda3qOr8vIuS2l6GltGRD6keq0n4itNAEg0jLgkfRuW
 z/JqhnUfYThkai3e7ECHAEgFBrn5sx2F5sr2K45npINwj43gpuP/HwIuXj+O5NX1OitCRhFD
 S5OyNnT7g//3URlJX/c3IP1WEKWxc55bsW7aGcbiWotqtpHA6CO4PlYjDN49xCm+BnJb6E3z
 VJ/gbM+rWQXiOYTtE8xwzWBV/oMSFJAM3WklgzUvYrn9uMNPjnpKOLukhMkzZf7UdTg6kldQ
 CqrIM54W3UqsYMmbRSUlyeuooD8JIuKNIhV7EfL1U6fybAScs15l+JW13A+ZiSi5zt8mrR91
 0A+msvr2erPY2R1oPDpWFgBaGCzPp5CvGmq1/gWn97Kjdr2QdM+QHNRBMSuFbXyT3oTrai1b
 V/RVmJm7C7KQ/yBQUjFtiIE5zrOC8z5ZyvRfSdEi484FV/EfxQXgRhIDmVg2MdnS0bwn5SnK
 h0xozkV4hSQRgJk7OVuOlG/V27eoFztcTIoUN2EKwIQ6Ahe5kDTOMjY7+RpHige8Ifz5AqKY
 neWYQhFFwRrEgSNGkzjM7+y5NLB7/nQB+ywKOHLaKmPruoWXumBxJam2I9rtziWMcDHMn5nB
 vw9kk1NOBIxU9zegCkKQjcLmjjlasmGuFGj9ycxos3+uPXnVQTz5JeeXrtfNdI8nnL+yayHN
 uOWmGN4MWMCj8lKnyWXjuFCmgdO2EQMP3G3HL8NtDDAVvfVk65TVFsAbj9rcdBP9+Q61xVMP
 sjSjpX00KR5h7g7EQQgNxSpl8e3aMgNO2z4OknAARPBEb2cJiDQhezzb7m9T7J4k+he8RG98
 2X+cQerLnGYmj/lWgr6e/lLlz2eNQdCtZuVdxFwFS78QdigZhDxY7oVxXUmhLYzgH3NL2sVN
 zNxJlhMorOn5iRdmvxjGmZF4xKNwsGblizf4+SKc/7+VNN0Dy4ym+8IuBzSKpNQ6zxYAuN4k
 m3eo4w2y2w=
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:QUc+l60u4vLqw/ngRt0Z7gqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:qpNlumMcMdyCp+5Df3Zk11wXM+kZXkLQzFqXYGHmUW9kcejA
X-Talos-MUID: 9a23:uwZYnQq/NiXSRPeP3b8ezxNFEMdUyPWCMnAijo1cms2DFWtAGw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,243,1677538800"; 
   d="scan'208";a="54819063"
X-MGA-submission: =?us-ascii?q?MDFtl7EGK1LB6TC1XfmTpZ2cXMU3MUZnZiypHy?=
 =?us-ascii?q?P9p5kZ5Rm4lN3Kjq9qXqMjcVSsov+LwmvbFnl4/878J14QBg5FQ23xMT?=
 =?us-ascii?q?Rjqt9KLJdBPpeYfpcby5L80r3zS29Ann6SE3uK4SCo6RkU5Jasa7coo9?=
 =?us-ascii?q?Gw3YVqQhcjZNEZ4QkvJVYvUg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 09:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1683012633; i=markus.elfring@web.de;
	bh=oWMGFV8YQkZIj0iDmQ6Xq881Lt3f2VNr7dhM9T5Ri70=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=j74wXyo8/zoNSgjX1BjNXSI67MPcCRHIi9gWNRHZnvtoW4w9mNDPsWexoBnRqY+5c
	 PV2tkrtPh/OkuZGAbfUnIcu1mbc1m2dcTrfFVLlGMybA7NCw8UGLlKdxcFNONlUZVz
	 Kabg6IJjQQK98lNjda5FAX+lpOjGYwT0W4sjiU873udvIwmgPjqtnPTw89AWXPqTUi
	 mNV2A9aXYqxzysKLHYqlqMOZKIips/lSB4TFBd0XoyDGWZCGzJ1qojlHuOYjARC/kT
	 mKz+DxkUxgn3P+1zZJ8WvMbylw2SaVJ3lGg7AEtJXj7/mf/i04ZVuCjed2QytR5AIv
	 3lUbDaZHigNJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1pZj2c1ciV-00Nl7H for
 <cocci@inria.fr>; Tue, 02 May 2023 09:30:33 +0200
Message-ID: <282f102f-818a-1fc5-afb2-24435ed3ccf6@web.de>
Date: Tue, 2 May 2023 09:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YzJmfhT/43zNQit9CnuUBsQEDTaPQPX7o44KXZsdAG+wVSH0Jon
 A2+bk17Uw9HlmLlfFTu/onOF+SIX08uyEqAjZP/v6isW5/2IoyGeKVZ1BVf8eANKvXROokm
 yadPaM1ESvqkAUJlcOEKnNBhNJzj+l91SCD3yVCxsBW3kWlbMevA5l+5DjkUWs3rQBnQtJF
 YD89BhwIoC90F/4eB2Ucg==
UI-OutboundReport: notjunk:1;M01:P0:yQzIjmdhCs4=;P8lVOO//7vBD5G86qTtjXhfTAdm
 rMTHpmHJnVAjrZvU3ykyb2fEBTx76+BjafqiRgBkNtK6GxBy/zqY1oreiWl2KzFZ0JVK/DTCo
 NKqPcUZ7zTkQRydOKl+tPojumLMgtTU4wpfWynAVKOAPrctMEssSJxXaaWdtdipKpSkDz/8R3
 KAzAhDCsRFIL92fcx5ajZuaCSEPAERnzHumoddSf0MLLBSugPSQCpgMdlQ9kVr4/9V/E0PCnC
 mzNaayM9K2shG5ReFdEzKNjQFAMw/TkzVBRGhrSlr/r7y6KiSkfOagcFBM6fL8g1gFqZDXLf3
 pm9KvmpUrvgkYPMeGGq+WXXItAYSSyEPkZu7WUaBQjPQu1MGNfj35Opk6AHjyz3X4Wv68+Fbj
 Zwryk69jXgEyK26XZCKNbL2wMKnJiFHRF4bhMtGelle2nGSEhW7/IYDaiVodANYfPrHgxH6LF
 1PK1Nb3y1uU68UIj9+OmbdKMAC6NIl3FJ0dPwC9Z1Vz5V+bvTI3sxccuNoQcGEWMflzG2XEqs
 19CgP0T1XFjSfkifHrdIYXt/nqIqxWv1E6ElCS5alHGegHETTdEGi9Bhv3KVFqItTgrCRgUku
 Xn4augKtAAt2c29qw1YlE2bvxN+gVNF9nyagLhctz8CMvVZ8OW5jt7oVDyUnGozRYOWF9o6uK
 05KMd/ztpIWcp2bvuO7IExqremOElsVeVxnzjLuPQrTU5wgVPwjUnxLWKYebx0azvXQ/BYN3i
 jI2E+DKVnb0SyHXyVUracK+ghGeOye8VZFLRYABKeRVNRQCDXHYnZXA00Aj+hbmF9GGgtDB5M
 OZLBX+LkivP9z50VIURcpew91fbCM9n/8DFgZ7S1LvgpuFGN02NuiATr0nZ7TkBnxW7FQCM2H
 SVG2s4ZG/WcvMdP+3zCO+DBiBMKElYiqaLgfnD65Y2haAdE/FsDf0fUfBjO6eRVMRn8y9Pwpc
 Nh+kmg==
Subject: [cocci] Checking data processing for the non-optional nest
 construct in SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1138
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/282f102f-818a-1fc5-afb2-24435ed3ccf6%40web.de>

Hello,

I tried the software combination =E2=80=9CCoccinelle 1.1.1-00467-g578998d7=
=E2=80=9D (OCaml 5.0)
out once more together with the following files.

Source file example:
// deleted
// See also:
// https://elixir.bootlin.com/linux/v6.3.1/source/sound/core/control_compa=
t.c#L79
static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
				    struct snd_ctl_elem_info32 __user *data32)
{
	struct snd_ctl_elem_info *data;
	int err;

	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
	if (! data)
		return -ENOMEM;
// deleted
	err =3D snd_ctl_elem_info(ctl, data);
	if (err < 0)
		goto error;
// deleted
	switch (data->type) {
	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
	case SNDRV_CTL_ELEM_TYPE_INTEGER:
// deleted
	default:
		break;
	}
	err =3D 0;
 error:
	kfree(data);
	return err;
}
// deleted


Another script variant for the semantic patch language:
@display@
identifier result, work;
expression action, value;
expression list el;
statement es;
@@
 int work(...)
 {
 ... when any
 int result;
 <+...
 if (...)
 {
    ... when any
*   action(el);
*   return value;
 }
 else
    es
 ...+>
*action(el);
*return result;
 }


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch ../janito=
r/show_common_exception_handling3.cocci control_compat-excerpt-20230502.c
=E2=80=A6
@@ -24,7 +24,5 @@ static int snd_ctl_elem_info_compat(stru
        }
        err =3D 0;
  error:
-       kfree(data);
-       return err;
 }
 // deleted


I would expect that this source file should not be presented because
the mentioned function implementation does not contain two required statem=
ents
within if branches.
How should the shown software situation be reconsidered?


Are previous clarification attempts also relevant for such a data processi=
ng approach?

2017-08-18
Get the non-optional nest construct completely working for SmPL
https://github.com/coccinelle/coccinelle/issues/114

Regards,
Markus
