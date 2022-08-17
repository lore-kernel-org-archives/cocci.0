Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEF3C25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=0E+082OZjliuc3yjmhRazzEQ6hQyzWl7581i6YbxK9g=;
  b=uMlvJrZRVUOD3lzpdMhIySv32qeHqpp+el1sA1Wt53ADJv8CLtMwwZjP
   y/3EFw7JWODUfdUGsGjzRKaG7uTQbweT+xlpb95BZrRQDWmrr6Nq998No
   JavvsqiP6IYOD0tnsjsLsbRLplYntfCAG76wqVo5Pqf9LBrQYln/VEVNr
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49037978"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 17:27:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E880CE0AC3; Wed, 17 Aug 2022 17:27:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 475C4E0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 16:26:27 +0200 (CEST)
IronPort-SDR: XN5bQ205VLl2q/sSTk7xKPgAcV8lbmjdKkhxm51neUnw8z4CSV4EmkQTtLeM2Vrm3b4p+plQ5L
 L9a/3Ins6vnxy3Q2j0C9fjUy7Q6WFX7+mT1OutHS/8+FOarCr9pLCaF+WgBiQYj02MBBKjwVBq
 JvBnS8xwenpV0+/fUBIPxlIZi3nGFs5fqw87mD7kV9cvGoEaVPj2JE1pV1ynpLhh61H0k4Kngq
 v9nPDpOvw7iFtCzw71GUxtpPgV2860XjQgj45NAxXYesadIaPUj+7Xb2Tf3SUG7aa5sCoT2UCv
 v6NyNZZMqCbO0nwW9EE7PDTA
X-IPAS-Result: =?us-ascii?q?A0BTAAC9+fxiXULaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFRUgcpAYEnLgRQhE6IH4ZIgiiEJYcOA4EGkEOBfAsBAwEMAUACB?=
 =?us-ascii?q?AEBghOCdAKEeQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBBhwMCAcSFQ4FYAFhAwFEgU+BdAsDMQ2CNSkBg2MBAQEBAgESER0BGx0BA?=
 =?us-ascii?q?wELBgULAQwCAiYCAiMRAQUBCBQGEyKCW4JtAQMNJQMBm1WBBEKKOHqBFQUXg?=
 =?us-ascii?q?QGCCQaCYYFuChkoDRVSA1t+AgcJAQh/LAGGTYh5J4EZgRCBPAwQgmc+hEQVg?=
 =?us-ascii?q?0E3gi4EmRAEBRQPAwMCIAMJBAcFLB4CCQMjEQMLEBEHDgEWAQQIAQQDAQEBD?=
 =?us-ascii?q?gIFBwIGAwMCAgICBQECCgIBAgQDBgYCAxABAgQBCgQCAwgCBwMCBgQKBAIIA?=
 =?us-ascii?q?gQFAw0BAwUCAwEBAwMCBAECAQEDCAEDAgMDAgICAgUCAwICAgkDBAEHAwIDA?=
 =?us-ascii?q?QQDAQIKBAQDBAICBwIHAgQHAgECBgMFBgICAQcBAQQKBAMDAwMCBQICAwIGE?=
 =?us-ascii?q?gYGAgQBAwQCCgICCwIHAQECAQEBAQIDAgcFCwEBAQMCAwYFAgEBAwgGAgEEA?=
 =?us-ascii?q?QUDAQQFAwcCAQUGAgkDAwkDAQEFAQMEAwMDAgcDAQIMBAgDAwIDBAICAgIBA?=
 =?us-ascii?q?wIHBQgEAgkCAgIBAgICBAIBAxoBAgMFAgIJCwEEAgIDAQMBAQIIBAkEAgMEA?=
 =?us-ascii?q?gEBAwIBAgIBBQIOBgEBAQECAwMBAgMBBgcCCAIODgoBAwMDAgIFAgIBAgMCA?=
 =?us-ascii?q?gwBAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCAgMBAQUOBQIEAgECB?=
 =?us-ascii?q?gUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHB?=
 =?us-ascii?q?QIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBAQEHDAICAhMCEwMBB?=
 =?us-ascii?q?gEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kAQECAgICAwQHAgEEB?=
 =?us-ascii?q?gMNAgIBAQEFBg0DAgMIAQwCBwMCAQMFAQICAgQBAgQKCQECAgECBAUHAgEIB?=
 =?us-ascii?q?gUNBQkLAQECAQMHBAMRAgUDBQUDAwIBBgQFAgMBAgEBAwQBAwQGAQECAwICA?=
 =?us-ascii?q?QYCAgEBAwMEAwECBgICBwIDAgEEAgMDAQEBBAICAgICAwMIAwIIBwUBBgECA?=
 =?us-ascii?q?QQDAgIBAgcBBAEIAgEDAwUDBAEKAw8DBQMBAwMCFAoFAQUIBgkCBAUCBQMCB?=
 =?us-ascii?q?AIDAwICCAMCBAMCCwMCBgQCBxMHAgMCAgUCAgICAgUEAwECAgICAgIFAgQCA?=
 =?us-ascii?q?QUBAgIBAgICBAECAgcEAgMBAwQOBAQCAgcBAgIBBgIHAwECAQQDAQEEAgQBA?=
 =?us-ascii?q?gUCBAEDAQIGAgQDCgICAwICAgYIAwMMCQIDBQIGAQECBwQCAgsBBgIHAgIBA?=
 =?us-ascii?q?gMRAQMCAQQFBQMDAwkCAgMCBAICCgEBAQECAgEFBQIEBw8CAgIEAgICAQMCA?=
 =?us-ascii?q?gEBAgIFBAkSAQECAwYEBgUDAggYAQYCAgEBAgICAwMCBgIBAggCBAEEBQIBA?=
 =?us-ascii?q?gICAgQBAwYCAwEBAgECAgMDAgEEAgQDAwEBAgECAgIDAgICAwICARACBgYBA?=
 =?us-ascii?q?gICAgIDAgIBAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCB?=
 =?us-ascii?q?wUCAwEEAwQDAwUGBQwIAQUBAwEFHwMCAggCBwIBBQMFAQ8DAgIDAgIBBAoBA?=
 =?us-ascii?q?gMFAgQCAQIBBAkHAgQBAg0DAwgCBwUYAQICBwQMCgICAgUGAgQBAQEBAwECA?=
 =?us-ascii?q?gECAwcCAwIEBQEFAgECBQQCAgEBAgUCH02ZHEaDYFiSFhStTIExBwGDVKAiB?=
 =?us-ascii?q?C6WXpIOlwKjCQGEJgIEAQEBAwcGECMSgSyCFTMaI1AqAQaCNj4QAQIBAQENA?=
 =?us-ascii?q?QIBAQMBAgECCQEBAo4dDBaDUIpgPzQ7AgYBCgEBAwmFRoU7AQE?=
IronPort-PHdr: A9a23:3eZaWRxkpwFB3E7XCzICwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZv6gzxwCVFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9q52uyo5ZHeYwRFiDW/bL59M
 R67sRjfus4KjIV4N60/0AHJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84T
 aFDAzQ9L281/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8
 ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfFjfK3SYMkaSHJdUcleSiJPAoGzY
 YURAuQOPuhYoZfzqVwVoBuiHAmsAf/jyj9UinL026AxzuQvERvB3AwlB98AtG7brNbyNKgJT
 Ou7ya7IzS7fYPNWxzj97JXDfxcjofGPWbJ9ctTdxVU1GwPKj1WQtZfoPzyQ1usXsmib6/BsW
 v6oi24isgx8pCWkycgwhIfTnI0V1kzE+jtjwIYzPdC2SEp2b9CrHpdOuSyUOYR7T8MiTmxmp
 is0yqMKtIC/cSYFxpoqxh/SZvibf4WW/x7uSOifLDV4in55er+yhgu//E69weP/Tsm5yEhGo
 jZBn9XWtX0A1wbf5taaRvZ+5Eus2DeC2xjN5u5ePUw4i6/WJp08zrIskpcetEDOETL1lUnqi
 aKbeEsk9+m05OnibLXrqYSTO5Fxhwz6Mqkjm8myDOQlPQQSWmWU5Pmz2KP58kD/Xb5ElOc5k
 rPDv5DfPckbprC2AwtS0os77hawFTam0NABkXYZLlJJZQuLj4boNlzPOvz4AvC/g1OjkDdv2
 f/KJKHuApLILnTbkbfhe6hy61JExQYt0dxS44hYB7IBLf7pREP9qd/VAgU4PgG12+rnDc9y1
 oIaWWKBGK+ZN6bSvEeK5uIsJ+mBZ5EZtCrnJ/gq5v7ukWQ0mVAYfaaz3JsXbGq0EehhI0Wce
 XbshMwOHn8QvgUiVOzqlEGCUTlLanqvR648/C00CJq6DYffQYCgmKCO3CCnEZJKZ2BLEUuME
 Hftd4WcQfgAciOSIsl7kjwFT7etUYEh1Qv9/DP9np9uNOnJ4WU1sZz51d56r7n2nAsx6CcyI
 sCTyWCLQElrk2lOSzJgj45lpkko6F6A1qIwoPtDHtxe47sdUAQ+ZcSEieN7F/j9XwvAepGCT
 1PwEYbuOi04Ut9km4xGWE16Adj3y0mbh0JCYpcQnr2PXtkv977EmmL2LIB7wmrH068oix8nR
 NFOPCuonP037BDdUqjOlUjRjKO2beIExieY9mSHnTDW+k5ZTCZ/VKzEWTYUYU6F5c/h6Bb6R
 qS1Qa8iLhMHzMeDLqVQbdi8j1ZCFK27ftvff0q+nm6xAVCDwbbfJJHydTA72yPQQFMBjxhV/
 XuCMl0mATy9pmvFEDF0PVfmYkep/Osn7X3lEAk7yAaFa0An3L2wkvIMrdqbTf5bnrcNuSN77
 i5xAE74xdXdTdyJuwtmeqxYJ9I7+lZOk2zD5UR7OdS7IqZui0R7EUw/tl7y1xhxFoRLkNQ75
 HIswg1oLKuE0VRHPzqG1JH0M7fTJyH85heqI6LR31jf1p6R9MJtoLw6qFGz5lnvGUs+23pi2
 thRlXCb49SCDQYfV47wTldi7wJz9PnRZigw4Z+R1GU5a/Hl9G+fnYhwVK17lEXFHZ8XKq6PG
 Q7sHtdPAsGvLLZvgF21dlceO+sU8qcoPsSgfv/A2aixPe8mkij16AYPqI17zE+I8DJxD+DS2
 JNQifOb2lvdD3HzjUuJvcX+mIQCbjYXVDnaq2CsFMtKa6t+cJxeQ2WtJ53tnpNxhoLFVHtR9
 VrlDFQDkpzMG1Lafxn22gte0l4SqHqslH6jzjB6pDouq7KWwC3Ex+mKmAMvAmdQXyEiiF7tJ
 dLxlNUGRA2yaANvkhK55EH8zqwdpaJlLmCVT10aNyTxKmhjVOO3uN/gK4ZN65d4630RX+WgS
 V+fQ7/55RAd1mvvEnBfyzYyazyx8s+hzloq1STHdSY18iSRcNo43RrF4d3AWfNdu1hODDJ1j
 zXaHBn0PtWk+8mVi4aWt+m/U2y7UZgAOSLvzI6GqG66/TgwWUz5z631wIS3V1ZkgkqZn5FwW
 C7FrQjxeNzu3qW+a6d8e1VwQUX74Ix8E51/lY05gNcR32Ibj9Ob5yli8y+7PNNF1Kb5dHdIS
 yQMxouf4gvhiBc7aH2I26r2U3ycxo1qYNzwMQZ0kmotqttHDquZ9ukOnyhx8gDg6w3QfdBym
 z4czb0l73tQ0IRr8EI9iy6aBL4VB0xROyfhwg+J496Jp6JSfG+zcLK02Rk2jZW7AbqFuA0ZR
 Gfhd8JoA3pr9ssmegGpsjW7+sT+ddLXd95WqhCEj0KKkb1OMJxo3vsS2Xg8ZCSk7CVjkbJky
 0Qph83yvZDbeTsxuvjiWVgBaGWzP4RKq1SPxe5fhprEgd7pR807XG1NBNyyFbqpCG5A66qhb
 VrfVm1k7C/cQ+KXHBfDuhg86SuTVcn6bTfPYyBJqLcqDBiFeB4A3EZNBmh8xthhUVn0jM35L
 BUgvmBXvwGn7EsKkqUyblH+SjuN/VjzLG5lFN7HakIRt18nhQ+dMNTCvLgrTmcIo9v49lzLc
 ivCOExJFT1bABXaQQ2zeOD/v5+YtLHJTuumc6mUOOvI87cPEazSg8roi9oDnX7EIMyLOjMK4
 +QT/E1FUDg5Hs3Yn29KUCkLj2fXaMXdoh6g+ypxp8T58fLxWQup65HdQ71Vec5i/Ry7m8Lhf
 6aZmTp5JDBE15gN2W6Ayb4R20QXgj1vcD/lGKoJtCrERqbd0qFNCBtTZyR2PcpOp6Uyu2sFc
 dbckc/w36Vkg+QdDl5EURnsmJjsa5JUZW66M1zDCQCAM7HHbTzHzsfrYL+tHL1diOIH0n/48
 T2fEkLlInGCj2yzD0HpYbwK1njLekIA6+TfOl53BGPuTczrcEi+Od5z13gtxKEsw2nNPigaO
 CR9dEVEqvuR6zlZi7NxAT8kjDItIO+aliKe9+SdJIwRtK4hACdwx7gCpns715Na6ShFQLp+n
 y6Y/bsM6xm21/KCzDZqSk8EsjFQmIeCpllvI43c/5hEHHvGpVcDszvWBBMNqN9oTNbovuoDr
 7qH3LK2IzBE/dXO+MIaDMWBM8OLPk0qNh/xESLVBg8IJdZEHW7ajk1Z1vqV8y/MxnDfgpfpk
 ZsKDLRcUQ5tfhv7IkFsHdhHLZUuGz16z/iUi8kH4Xf4px7UFp0ygw==
IronPort-Data: A9a23:zBSdCKkdig4QTNzBDJW47+vo5gyrIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbWWyFaf/eNGHwe9lxb47kp0gPvpDUydZrHFM/rns8RVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09UAbeSRWVvX4
 4ui+pKHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /0Qv8W5dzwPEZTNlepeCxUAFAVMA7ZZreqvzXiX6aR/zmXDenrohvhsVQQ4Y9Ne9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELA8wJp9RCXoFNt3VnVIzzLdXax+B5/CX43F4NZZ2HE7gcUm8fP2O
 5tBMmIzM0yojxtnYQ8qEc4+vu6Ul0b5IxJGonWuprQ3/D2GpOB2+OG1bIC9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmk9AncfKlCL/HY8QTfi2qKAsj1qUyWgeThYRUDNXvMVVlGbjUYtWF
 Xcy1RMvoKZxrEDzSf3PYQan9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVsctKnQIx23CPRbWx6v
 mJlj+8FFhQ07+LIESP1GqO86GLtaXJMfAfucAddFVNdi+QPtr3fmf4mczqOOKu8j9mwFDOph
 j7U8m4xgLIcicNN3KK+lbwmv95OjsiTJuLWzl+PNo5A0u+fTNP1D2BPwQWEhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSC3wYxQMV/rWn2py7LkWVsDNdWdBcB3iEsKW+BX
 aMvkV45CGJ7Zyb0M/cmM+pd9exznPGxTrwJqcw4nvIXOsQrHON21C5pYkGU0gjQfLsEwMkC1
 WOgWZ/0VR4yUPw5pBLvHrt1+eJ1m0gWmDyKLbimnkzP+efPORa9FOZVWHPQNLxRxP3f+239r
 Y0PX/ZmPj0aD4USlAGJod5PRb3LRFBgba3LRzt/KLfefVU+Rj5/YxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFXLdleHbG5NcrTqUcotpH43J31+MlOh2nxlaoGqtf9Ne5wydLgh1epi0f8kF
 6lfK5vcWqxCGmbd5jAQTZjht4g9JhmmgAS5OSD6MjUyephXQRPEp43/dQz1+ShSVSe67JNso
 7Cp2g7Bb4AEQgBuUJTfZP61ngG+uHEcnKR5WE6Reotff0Dl8Y5LLS3tj69vc5tcd0mbnjbDj
 lSYGxYVo+XJsrQZytiRiPDWtZqtHst/AlFeQDvW4LOwAi/QoTiuzIpGZ+CXJGyPWW7x/pKiU
 uVb1fTLNvMKwQRRuI1mHrc3lK8z6oe9p7JeyQg4TnzHY07xUeFlK3iCmMRN7+hDmOEftgyxV
 UaCvNJdPOzRas/iFVcQIisjb/iCha5IwGiMtaxtLRWo/jJz8ZqGTV5WY0uGhhtbIeYnK4gi2
 +og5JMb5lDtkBYsKdra3ClY+37WdS4FWqQj85wYWcrl1FRtxVZFbpjRTCTx5cjXOdlLN0ArJ
 B6ShbbD1+sAnBucKyJrGCifx/dZiLQPpAtOkA0IKWOPl4eXnfQwxhBQrWk6Qwk9Is+rCA6v1
 rWH9nGZJJliOx9tjclHGm2uQkRPWkPf9Uv2xF8E0mbeSiFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmXzW/kVXDhe8SZMu4aRxt+s/K6JTBu3lSqpS1kdvhp27E1ZDPkhumlYm9gR94Lxy8urBWvm
 NSGN9qcpUE22eD8bkH750SnOWwsdS25
IronPort-HdrOrdr: A9a23:zdx+UqNVL+/PdcBcTsyjsMiBIKoaSvp037Dk7TESdfUzSKGlfq
 GV9sjzuiWUtN98Yh0dcJW7Scy9qA3nlaKdkLN/AV7KZmCP01dAbrsSjrcKqAePJ8SRzJ846U
 4ZSdkYNOHN
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49030470"
X-MGA-submission: =?us-ascii?q?MDFgM+6Lpi825SKbGcSbNDWnoQ9j9GcIfhaJBc?=
 =?us-ascii?q?YtVXO2gau0PRcEDxkQb33hRHxnd49k1yhSffzhjNv5CdNKf8X/liYx74?=
 =?us-ascii?q?cURyX/AmqfTiXcEiSy17uzmTbJakMRXZdwPDzbF1DSBpOF/OgHhh7x0p?=
 =?us-ascii?q?ifE9mDGH0/dhHctxcIKI1jyA=3D=3D?=
Received: from mail-ej1-f66.google.com ([209.85.218.66])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:26:27 +0200
Received: by mail-ej1-f66.google.com with SMTP id j8so24815245ejx.9
        for <cocci@inria.fr>; Wed, 17 Aug 2022 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=0E+082OZjliuc3yjmhRazzEQ6hQyzWl7581i6YbxK9g=;
        b=XSo9QaZ59C5Uj9jZgXWTqAUSIC3PbmREyb5DA4c25bunQrE+Uci3SCWVfE9RAWZxix
         eRQt3+Vid7MjQAfsLNRLn8j4VrBsWk+8DP2uKoLqJn+0b7nL3F7Cz0p2PpTcWqONlmYx
         JHjezrKNbOQd0S0w/xVhtsrLAraoZk9/IvlqtIqzm3N1LMO7gB5ifEzbzjv1FEpgCwHf
         b5iJO4SrNFlcJOIW/oSdWOpgvRyrhbzJJV6Fi5Ozfl+F4L9lkQKwGTwCbiPFr8yXdpXQ
         Ql5aukKbPrgGMrD3OZprFOHbr51tdQF1kcz1a4ZCQ30twZ7JHbNCuBD1c4oJBuOre0GH
         Ug4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=0E+082OZjliuc3yjmhRazzEQ6hQyzWl7581i6YbxK9g=;
        b=utcbZtQwQjW4CzzcsLGvwIOnnfpShSDihFok9cvqR5x9fRyqTAg98JOM++adMni8KV
         yzohm71IOm2opOzSSiLIkhz8AxKV4AcNp97HrLl3lyuOd+rORUzoLJ6vLhu6VI7QPWtL
         8Wom3DnOOzJpcjOzNnIgFl4+Sw9VhRGOvxIHG43QX+6f91km4UoDicLUZDrpjNN42TAf
         Nzy5K3ZRU9vvjFEJ5xrBncAzyQgWDVwqiHtGxrnWsvF6wq3fMLcZ9dqB0bg8AnpiQTx4
         aYMsMHzysLxX7rYpTIe3lmtBf0Blr2Q9BggZ0RabF080rdHoqc9Xkjd7l4sIkkniMcX8
         9QCg==
X-Gm-Message-State: ACgBeo1+tF1j9FqFoPHw53ZFl5jn2HjO0hF6QKI3Y2uDka6vebxYdpyl
	A1kmq0WSiQMElypod6wZRf1KznQrvntunA==
X-Google-Smtp-Source: AA6agR66fM/9KRi/OvxtpxQDR+dtn3TN4irpHitqjLIijS8W8s7CD9J9Mk16ba1pjH2AFMbQ8CxEXQ==
X-Received: by 2002:a17:907:7245:b0:732:f72f:44e3 with SMTP id ds5-20020a170907724500b00732f72f44e3mr16273767ejc.503.1660746386091;
        Wed, 17 Aug 2022 07:26:26 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:f4b2:956:5d0:dd2a])
        by smtp.gmail.com with ESMTPSA id e20-20020a50ec94000000b0043c83ac66e3sm10733818edr.92.2022.08.17.07.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:26:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <5c4fc14e-bf4e-8bbc-cc9e-0b04c849eca5@web.de>
Date: Wed, 17 Aug 2022 16:26:24 +0200
Cc: cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <8080D5E0-2491-47A0-AEDD-3EB84661917F@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <5c4fc14e-bf4e-8bbc-cc9e-0b04c849eca5@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 514
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/8080D5E0-2491-47A0-AEDD-3EB84661917F%40gmail.com>

Hey,

> On 16. Aug 2022, at 19:55, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
>> looking at the following code snippet:
>>=20
>> test.c:
> =E2=80=A6
>>      func3(argc, argv);
>>=20
>>      func3(argv);
>=20
>=20
> Would you like to handle function overloading here?

I'm not exactly sure I understand what you mean here.

Finally I would like to archive something like this:

void func(void) {

    int x =3D 0;
    int y =3D 0;

    func1(x, 0);
    func2(0, y);
}

void func1(int arg1, int arg2) {
    interesting_func(arg1);
}

void func2(int arg1, int arg2) {
    interesting_func(arg2);
}

In the end I want to, for example, turn it into:

void func(void) {

    int x =3D 0;
    // 'x' was used as first argument to interesting_func
    int y =3D 0;
    // 'y' was used as first argument to interesting_func

    func1(x, 0);
    func2(0, y);
}

void func1(int arg1, int arg2) {
    interesting_func(arg1);
}

void func2(int arg1, int arg2) {
    interesting_func(arg2);
}

Basically I want to flag create the matching from 'x'/'y' to the =
argument to interesting_func.

I was imagining if I could match the parameter list of any function =
calling 'interesting_func'
then I can also create a matching from x to that function call and do =
the rest of the correlation
in python somehow.

However I'm still failing to detect if any argument (arg1 or arg2 in =
this case) is used as
any argument in 'interesting_func'.

I hope this makes more sense?

>=20
>=20
>=20
>> what doesn't work (matching on the expression list from the parameter =
list):
>>=20
>>   @main4@
>>   expression list Es;
>>   @@
>>=20
>>   int func1(Ps@Es) {
>>   ...
>>   }
>=20
>=20
> Which type would belong to the metavariable =E2=80=9CPs=E2=80=9D?

Ps should be an arbitrary length parameter list with arbitrary types.

>=20
>=20
>=20
>> I also tried this:
>>=20
>>   @main4@
>>   parameter P;
>>   expression E;
>>   @@
>>=20
>>   int func1(..., P@E, ...) {
>>   ...
>>   }
>=20
>=20
> Does such SmPL code represent a contradiction?
>=20
>=20
> Can any other descriptions indicate your data processing imaginations =
better?

hopefully the example above makes it a bit more clear.

>=20
>=20
>>   @main5@
>>   expression main4.E;
>>   identifier func;
>>   @@
>>=20
>>     func(..., E, ...);
>>   + // add comment
>>=20
>>=20
>> But it throws: 'rule starting on line 41 contains unattached =
metavariables: main4.E'.
>=20
> Which software version did you try out here?

I'm guessing this will give you all the information you want:
spatch version 1.1.1-00124-ge93f5513 compiled with OCaml version 4.13.1


>=20
> I am curious how corresponding considerations will evolve further.
>=20
>=20
> Regards,
> Markus
>=20

Thanks!
Jakob

