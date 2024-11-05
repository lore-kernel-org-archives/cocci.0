Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0BED2B920
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2024 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hqCtyPooln+4t23APYcj1PASVdkN+Jv76mgg0v3ychQ=;
  b=JOwFVFNiszaDHHX6RqZWtVCwLRzH6VXFXw6eeTtNWSGirDMz3Uy/C5XX
   J6IN8qxA+QDO1NtnW9pD9H8gNH97SHQ1Im/p6kImFUeNZbf5ZoDjsrPHu
   l0HbE3yoMFdhzXnXen703RfHQr43xoi/IcYrzHMoK2TlbpC8vBQzZBsHE
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192250265"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2024 14:03:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ECEF6E0DB0; Tue,  5 Nov 2024 14:03:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DDAC5E0133
	for <cocci@sympa.inria.fr>; Tue,  5 Nov 2024 11:30:41 +0100 (CET)
IronPort-SDR: 6729f3d1_w6rYayFfxJfzKzJ5GDlhebl/ekZS4Z+AxE+hn+6EngzyMTM
 zeoYG2ktKcrraowuDCSkTRxsE27ZQjqOZuaHqig==
X-IPAS-Result: =?us-ascii?q?A0FVAABv8iln/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDB1sbBlQzBAtIhFaPTYF0LQOEO48PiHWBVoF+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwMBOIFUgnQCijQCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJwQLCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn0Bgi8BAw4jBw0GrxSBMoEBggwBAQaBWEHYQh8sIleBZAMGgRouAYVpg?=
 =?us-ascii?q?mIBhiSDK4ERJw+BVUSBPIJSMT6CYQEBAoE1KYNbgmmCNhWFHyWILWiXY1J7H?=
 =?us-ascii?q?ANZMgFVExcLBwWBKSQsA4F6WH+BOYFRAUKCXUqDPYFeBTdJgkppTToCDQI2g?=
 =?us-ascii?q?iQkWYJQgSUEBYNvgQuDZYRsfR1AAgELbT01CQsbBj2eWkeCaIEkLSwvIMdtN?=
 =?us-ascii?q?AeCOIFlgWMMiieVLgYTL5c/DgaSeph3Io1dmyOBbgguRoETMxokgzZSCw4Pj?=
 =?us-ascii?q?iEMFoNYM4ELwl1CNQIJMAIHAQoBAQMJhUYBAYoKNIFLAQE?=
IronPort-PHdr: A9a23:ngOAvRFrx2coRXRjMhzzPZ1GfwlGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21BmTDNWQsq4MotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiaxbalsI
 BiyrgjdudQajIR/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9l7xQrg6/qBNjwo7UeICVO+R4fqPBZtMRWG5NUt9MWyBdHo+wa
 o0CBPcDM+lFtYnwv1gAoxWxCgaiGe3h1DFIiH/00qIm3OosCh3G3BU6Et4SrHjYstf4OaEPW
 u611qnIyjDDYutR1zjn8ojIcQ0hoeqRVrx/dcrRx1MvFwLDjlWftIfoODSb2f4Xs2iY8upgT
 vijhWEjqwF/uDivx8EsiobSi4Mb1F/L7j91z5srKtChTkNwfNGrHodKuS6AK4t2Xt0tQ3tuu
 CsixLALup61cicExpk62hLSa/+KfoyH7x7/VOufLit0iGx5dL+wiRu88VWtx/DiWsSp3ltHs
 DdJn9nQu30T1xHe9M6KQeZz8Eem3DaAzQHT6udcLEA1k6rbMZ8hzaQqmpodq0TPBiD2mETqj
 K+Wa0Ur4fKk5PjgYrXjoJKXKox6ihnmP6gwh8CzH/40PhYQU2WZ4+iwyb3u8Vf3TblSivA7n
 bPVvZ7HKcgBpaO0ABVZ34Ij5hu5EjyrztAYnWQcLFJZZh2HlZXnO1DPIf/mFfqzn1Khmypxy
 f/cJL3uGJDNI2DDkLj/ebZ97FZRyA80zdBC+5JYEL8AL+zoVUPrqdPXEAc1Mw2yw+n5FNVwz
 p0SVX+RDqODLq/er12F6vgyL+SMfoMYti7xK/0/6P7viX85l0Udfa6s3ZYPb363BO5mI0aEY
 Xr3mNsPHmMKvgQkTOzrjl2CXiVeZnisUK0n/D00FZypAZ/FRo+2mLOBxju0HoVKZmBaDVCBC
 Wrke52eW/gQcCKSPtNhkjscWLe9TI8uyQ2htA7hxrp8LuvU/zUYuoj52Nh04e3TjxAy+iZuA
 8STyWHeB11zyykkSiU73+ha5wRfzVGOyuIw1/BVD9FQz/BPVRw9O9jXyKpnCIa2EgnGddyIY
 FegWNSvRz8rHfwrxNpbRk9nGMi5xj3H0TCrBbBdw5mCHp8p6eTx23brJsBy42nL3u8tgg91E
 YN0KWS6i/snpEDoDInTnhDczv7yHUx99CvE9WPZiHGLoFkdSgl7F6PMQXEYYELS69X//ELLC
 bG0Wvw8KgUU78mEJ+NRb8Hxy01cTaLGMc7dfnn3tmO+HxeOyZuTYYCsd2hOlD7FBh08mhsIt
 W2DKRB4Ay6gp2zECzk7MFv1YF73t8R6pmm6SEAc0AyAKUFshPKu4hBAo/uaRrsI264c/icsr
 zIhBFGmw9ffEMaNvSJke7hAJ8ww6hFL2Ao1riRbOZqtZ+Bnj18aKUFsul/2kg9wAcNGmNQrq
 3UjyExzL7iZ2RVPbWHQ25e4IbDRJmTomXLnI6fLxlHT1sqX8aYT+bw5rVvkpgSgCksl9T1uz
 dBU13KW4piCAhAVVNr9VUM+9h4yoL+/AGF1worO1mB3d4SwvCXD3d0BG+YvjBqtPp9ePK6CC
 A7uApgCHcH9YOcumlWvclcFJLUIrfRyZZn5MaLbnvX4WYQo1CirhmlG/o1nh0eF9i4mD/XNw
 45A2faTmA2OSzb7il6l9MHxg4FNIz8ITQ/dgWDpApBcYqpqcMMFE2CrdoeSz899moWrdnpW7
 l+lCHsZ1cXvdRfYPDmflUVAkF8ap3Cqg37y6jVukCwy6Ieb0jbPxevKaxcNfGJGDjoH7x+kM
 c2/iNYUW1KtZg4imU6+5Er08KNcobx2M2jZRUogkzHeF2h5SePws7ODZ5QK85Y0qWBNV+/6Z
 1mGS7n7qh9c0iX5HmIYyippPz2tv5z4mVR9hgf/ZD5WpWDaZNo26BPR/t3aStZO0zBASCQwh
 TTMB1e6NsWk5p3Ozs2F6LrhETv8EMYbeDKj1Y6asSqn+WBmZH/31+u+nNHqC0ly0CP20cVrS
 TSdqR/9Zofx0KHpeeljf0RuGBr9858gQ9s4yNFvwshNnyNJ4/fdtWAKmmryL9hBjKf3bX5XA
 CUO38aQ+g/unktqMnOOwYv9EHSb2MpoIdegMQZ0kmow6d5HDKCM4flKhyxw9xCdpBjSfOM7s
 zMT0/oo51YFjutPtAdnnUD/SvgCWFJVOyDhjUHCytmkr7hMIkurf6Kx0kVWgt2rSr2P6FI5O
 j6xatIpGil+6d96OVTH3Sjo643qT9LXaMoaqhyelxqTx/gQMp86keAGwDZ2IW+o92Nw0PY11
 FY9uPPy9JjCMWhm+7i1RwJVJiGgLd1G4Snj1O5XzMORwpzpAZhrXDkGFJK6SPW1DHcCu/P9K
 A+UHHsjp33dFbe6f0fX4RVjqG/TVpqsKnecKT8GwN8kSBTVLR5ahx0IGT4hlIM9FUbzzcrtK
 QFy4TV0hBawo0lJzf90chLkWWDFvEHxYzE4Ed6UKx8e+AhG4w293dW2yOV1EmkY+5SgqFbIM
 WmHf0FSCmpPXEWYBlflN73o5N/a8uHeCPDsZ/3JKa6Dr+BTTZLqjdqmz5dm8jCQN86OImgqD
 vs13VBGVGx4HMKRkisGSigenSbAJ8CBoxL09ipyp8G5uPPlPWCnrZOIEKdXOM5z9gqehKCeK
 6iPiSw/JTsZnpIAyHnUyaQOiV4fjyY9ElvlWb8EtCPLUOfRgvoNVkRdMXkscpIVqflvu2sFc
 dTWgd70yLNi2/s8ClMfEEfkhtnsf8sBZWe0KFLAAk+PcrWAPzzChc/tMsbeAfVdivtZsxqot
 HOVCUjma36mniPqSgvpHOVCliCdMzRBtYv7fhsnWg2BBJr2Lwa2NtN6l2h82bovmnbDLnIRK
 xB5dF5R6KKd52VUj78sfg4JpmogJu6ClSGD6uDeIZtDqvpnDBN/kOdC6Wg7wb9YhMmhbON4k
 m3eo4w2y7lHuuyI1yYhTxdE7DpG1trjVapKJqjTsJVNCy+swQ==
IronPort-Data: A9a23:7EaaWqpXCxBajuY5MJ6NbhTxcSpeBmIMZBIvgKrLsJaIsI4StFCzt
 garIBnVbK2IYTH8e9gkO4Ti9E9SupSAnd9rTFFq+Cs9E3kao+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvvrRC9H5qyo5GpB5gFmP5ingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2krIK4fpMxQJVpn1
 uY9bzwDbS2viN6PlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJsm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PttuTGPnVIpuFTrGOX4Vd+BeNQSpF+dh
 3/v1kPmLCpAEuXKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyHGWohDGd0XQiBa5UtQ0AbK8vsVjgO1R4sI4Ijp1B1ToihZEb8E68tA7T3om2
 zdlWj8v6SNH6NWopbC1r994bg9e/QAKIGVEaSJsoc4t/Yz4uI9q5v7QZo8LLUN25+EZ3Rnvz
 jrMoCVWa3D/SyIU//3TwG0rSA5AanQEosDZK+kXsq+YAttFWbOY
IronPort-HdrOrdr: A9a23:5gliq6qvDBuCW56DzYbr82QaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:3iUxQGO1pVeM+O5DRTRE8xA+PeQeW17H6TDcLUyFJWlVcejA
X-Talos-MUID: 9a23:8Eic6Amb6vFXbnCxov26dnpdGehr6Jm/T3oUlLQbkuCjKgJLYRGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,259,1725314400"; 
   d="scan'208";a="192214960"
X-MGA-submission: =?us-ascii?q?MDGpR8Lspw2gx8vJTt+pRoCU0y+pC0NswBf9kt?=
 =?us-ascii?q?EBB2yEqYb+CpDdqHWKy6W1EduauMZadbxvAQPYCfz0xeYa5Q+P9Y/9E4?=
 =?us-ascii?q?E/oh4MyZyipqxoQLiOY2G1olUkUe4YwTgiWIvKn01FkLXNLtr8eqYP97?=
 =?us-ascii?q?zkNkGe3eyUReK6WGKlY+smWg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:30:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730802630; x=1731407430; i=markus.elfring@web.de;
	bh=hqCtyPooln+4t23APYcj1PASVdkN+Jv76mgg0v3ychQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aKCrrvs9jJht0xyaXVSCYl0CTrgyPUYW3UCIhA7xmQAKYJkLRY1K138yZnQ9CI+/
	 BEibF/pidGRlMkhGBrcx18pF0CVpShr/xkz26US2bzHlmNOoF0MuTxAjIwwLXFuCE
	 r/d6hvtPANEY6FHYB0uLRg/Uy1Ojs39ufdGQlPd4JiQUxNueDsUHAQX2RQSjZdp+y
	 Y8QQa0Ed585nbYi02i6/h+2sKYxh6rAjQ9lG85l44JW1Epcksr5mJcWC+qCoo7ecK
	 vgJYcGuaqSwBSMXALKL/GU5HpokI7MofUIZt7qbYpy5ty6PaSHzTUaoJyHFH+tAI2
	 2wHLxXT5yIt8K/+Fvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1tNKhz3guf-00WuGu; Tue, 05
 Nov 2024 11:30:30 +0100
Message-ID: <9dbf4109-9cf4-44d2-8b96-7354e73bba0d@web.de>
Date: Tue, 5 Nov 2024 11:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
 <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJQeRSrf3HpoBk2IPIuAUA8+xJJfK952aYoDanq0u6ZXQxKD8O4
 dEk3rO3Eatmfah9qEroZOUALlHIunHKNMzxwM8/XFVaxCW1aLYiwFiyP4odKVYrkQroxOi/
 pdL0Zy6RmDHxik4Uv7K5gYPveCIM7szPaYI5jCb14R6aP2sMGjxTZDNWJKmOlbf2C4FX7qZ
 0Mu7U9vnHIIH2VgpsDS/w==
UI-OutboundReport: notjunk:1;M01:P0:2sBzF8jtuLQ=;9jzgrQTUA1IiiHZZwD00oYABT7d
 eqmnlac14olLfGqEdFX1lwp5Gd2/N60IGKMQ0LSQtf4wXCJZV99yh05VcMtDJT6IJUBPVQF4Q
 0UNIzJI+qfQn/46NN14qWT/KoRXEXI7+3zA0muTOftb78I09hdpU2Aaf5geYC9tQaxR8mXXIt
 U5bwrCawvXANn9DW3DPfh4/v3PTtX0yl8q0kdXK6/wKD/0B+seSlPX9JfbemlLRvl86dyGxhL
 MnW0j6nd7nh6oaZjN7Kit+Pm1Ka0JgYfyAMPsJPAdF7ezABwJrOcHXeoT1VN+y3wO3SOYIUVp
 Ke0Lm+Kp4QgZ7Gx9UWVW8Ep7Mrr3pgB20LqYEFUJm447/TW6EscOYYw/6n/ltBJC4HcW0o+ZF
 FwMEfmkkieXy//nC5PRqELKIbcwkqqxXcDDCquC39W4uOsmhckFAjiuTiCInYNl3zv2+UU3OJ
 W4wFPLiZwZpqJY0qhB+N9Sna6zKwAxJO+o0PMl15okv4uffBpX0Kdmv8WYUz+UBrPMJBX6MrE
 2S2FXXFh4pe0glFDL46ZaHGEfEGDd2VbEaFBbJMUHPlfA0IQJBGm3AMeGuqUgjyVN64T7umiF
 id0st3zWdPiZ5IACYTCf00Q5iZCgsZLHuNZy++n61oTcSM/4Nq0Kb9Mf4rAw9i4xUW3sVqSTk
 qKedsDZ6SYYBj8qnDbUY0PTVP3jyjP5fCmkR/nkv3NPG1wRnhuHrxjRzUxz7PoovVR6GWls8O
 fyPM+Z4yy6EVGeXE33tacU6+TxjRmOjMyL0HiWkMvc28F4a6RPwBFSpYbOrGeaQDaJgZEsNhk
 AJUhmhjczKo1qBqcwTZEEjkA==
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1966
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9dbf4109-9cf4-44d2-8b96-7354e73bba0d%40web.de>

> Using a graph database implies that a particular kind of
> query is so common that this representation saves time.

We are trying to optimise data processing approaches to some degree,
aren't we?


> What kind of queries did you envisage running,

I suggest to take another look at the properties of known source code sear=
ch
(and transformation) attempts.

The Coccinelle software collaborates with a tool like =E2=80=9Cgrep=E2=80=
=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/84e6b61cb7c20fecabe59=
62fcdf881418c84129d/docs/manual/spatch_options.tex#L235
https://github.com/coccinelle/coccinelle/blob/2b374187ace51a5569272642c443=
dcf1f61a1204/docs/manual/spatch_options.tex#L235

Big code bases (like Linux components) can be filtered to data extract siz=
es
which result in data processing times that I can tolerate for my
computation environment.
But I came along search ideas which can not be pre-filtered in such
a simple way.
Thus I got the impression that my computation resources would be too limit=
ed
so far.


> that would make using a graph database worthwhile?

I hope that more intermediate data processing results can be stored
in advanced information systems instead of known file management interface=
s.
Which databases will become more attractive for corresponding needs?

Regards,
Markus
