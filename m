Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CA5CAC5BB
	for <cocci@archiver.kernel.org>; Wed,  8 Oct 2025 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DTroHWXO3np9YNLGPDFuczXSAENWfhOZ2u7weiLIE5k=;
  b=fPdRb3kGZQbY4jvzbWN518OYAKQFG0janDsbPBcPhtoNviX3T8iEnuVt
   shIpuestH+tx44N00gkpuqw+k4hS/9f/OBRKn2pnd6uoDo95I2pgQqDRM
   5zEx1fe+Un13zmrJpz8npkYL+S/Co9qEW93K3qPBp4N+D66799fYlRq+i
   Y=;
X-CSE-ConnectionGUID: LnpNwRkmR+20uoHS+3aUmg==
X-CSE-MsgGUID: LgCf7DXcQ8egH3P76HYzXQ==
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
X-IronPort-AV: E=Sophos;i="6.19,213,1754949600"; 
   d="scan'208";a="243125507"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2025 15:31:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B296EE0171; Wed,  8 Oct 2025 15:31:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D50B9E0171
	for <cocci@sympa.inria.fr>; Wed,  8 Oct 2025 15:31:28 +0200 (CEST)
X-CSE-ConnectionGUID: WVYGa3UJRMyrbhhvHO3H0A==
X-CSE-MsgGUID: otk6zIjXTJWXYHUF/zxU6g==
IronPort-SDR: 68e6679d_m/yK3w6aGqpUaJYONoIY8Tyg7OEwnjMh60L8l0hnmkUiFdh
 /XKmTWyWkEu5gHidiTmnf6obFDy8oINfU08Czqg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HyDwBfZ+Zoe07ASNlaHgEBCxIMQIFFC4JAZR0GWDMEC?=
 =?us-ascii?q?0kIhE2PUoIkaYNSjxGKToF9Ag8BAwENRAoBAgQBAQMEggyCdAKMRwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAUIOO4ZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBEScECwsaAiYCAlYbA?=
 =?us-ascii?q?QGCfgGCIgEGEAEDDycHDQavZoEygQGCDAEBBoJp13YfLCJZgWQDBoEcLoVtg?=
 =?us-ascii?q?mQBhVOFECcPgVVEgTyCUjE+gkMHFwSBXk2DDoJpgiaBFYk2jF5SeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSBDA4EPIw88BS0dgSciIx4TZD0XQYNMHAZoDwaBExlJAgICBQJCP?=
 =?us-ascii?q?oFqIgYfEgIDAQICOlcNgXgCAgSCL4ESgioPgzQCAQttPTcJCxsGPZF/gnl6P?=
 =?us-ascii?q?4JIxjI0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQaOCJs5gWg6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQAM7NfQTUCATkCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23:/YzV/xSTHoe4HOfTaLUZHJgO+9pson+VAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODt7kd07GK6uigATVGvc3a9ihZMdRlbFwst4Y/p0QYGsmLCEn2frbBThcRO
 4BvcmEg1FyAdXZvJcDlelfJqWez5zNBUj/2NA5yO/inUtWK15f/2O+94YDcbBtVjzShf7xyM
 A+2rQLMvcUKnIduMKk8xxXHr3dSZ+hbymxkKU+Pkxvy6cq84YNo/yBMt/487cJNXqv3cqoiQ
 bBEAjkqNn0+6dH2uxXEUQaA6XwQX3kMnBFVGQbF9hb6Xpnwsiv+qOVw3TSRMNP1Q74pRzms9
 r9nRhDwhigILjI07m7ZhNFogK1UvByuqRp/w5XJYI6OL/pxYrndfdIBSmVfWMtaSjFMDZm9b
 4sLCOoBIPpYoozgrFYAsReyGQ+hD/7pxzRVhHH5wLc63vwiHw/I0wMvEc8AvnTKotX7NqgdT
 e+7wbLUzTXadf5axSvx5JbKfx0nvPqCXahwcc3UyUQ3EA3KlE+QqY/4PzOOy+8DvGyb7+R6V
 eKujW4npBx6rz+oyMg2kInJhZ8Vykve+St2xIY1K8e4SE99Yd6rC5ZRuT+VOJBsTsw/XW5lo
 SA3waAJtpCnZiYF0ognxwLBZPyddYiF+gzvWeWfLDl3mH9reLyyihK9/EWk1ODxS9e43VlKo
 ydbnNTBuG4B2h/O5sSZVPdx40Os1ziL2gzO9+xKIUE5mLfdJpU8zLAwkZ8Tvl7CHi/wgEj5l
 6iWdkI4+uis6uTnZK/qqYObN49xjAz1L6cgmtSnDOgmLwQDXXKX9Oai2LH54EH0RKtGguc0n
 6TaqJzXIcsWqrS3DgNIyIou7wizAy243NkXmXQKKk9OdgidgIjzIV7OJej1DfehjFSolzdm3
 /XGPrr8ApXRNHTCnqnucq1n50FB1gU/1dFf55RKBbEdOP//RFL9ud7CAhI7LQC42fvrBdFj2
 o8EW2+CAbeVMKbIvl+J4uIvLfOMZIgQuDvlLPYq/eTujXwkmV8GZ6Wn0p8XaH6iHvRnJUWZb
 mHhg9kfHmgRpAYxUfLlhEWYUTFPf3ayQ7485jYjBY26CofMWpyigL2a0SegHpxWY3hGBUqWH
 XfpcYWEQfYMZziILs9viDwITb6hRJQ52hG0qAD606ZnLvbT+iAAqJ7vzNd16PPUlR8x7zJ5F
 8qT3W6VQ2FugGwIWTw40rpnrEx4zVeDzLR4j+ZWFNNN/PxFSBo1OoDEw+NnCNDyWwfBc8+RR
 lipTNqoHy0/Q843zdMWfkl9Hs+tjgrf0CeyG7EbjqSFCpMs/qLHx3jxKd5wxWza2ac8klcqW
 tBPNXWohqFn9wjcGYrJk0KBmqiybKoSxCHDpy+/yj+Fu0pTUSZxV7/EVDYRfBj4t9P8s2bLV
 byzEvwKNgVbyMiNYv9vY8fqkE4AafPtItXYbEqulm32CRveleDEV5bjZ2hIhHaVM0MDiQ1Gp
 R5uVCA7Dyal+CfFCSB2UEnoewXq+PV/r3WySgk1yRuLZgtvzen94QYb0NqbTf5bxbcYoGE5s
 TwhOV+n3M/NTfeEqRBgeqp0ft43pltKhirCrwIoBpW7NOh5g0IGNQF+vkfgzRJyX6BJi8s3t
 zUHyARoKKSX+ExMfXWU0MO4IaXZf0/1+h3ncKvKwhfe3dKRr78I8+g9ok7/sRuBE00/7zN43
 tMT33b0CoziKg0UXNqxV08280M/vLTGemwm4JuS03RwMK6yuzuE2tQzBeJjxAzyN9FYeLiJE
 gP/Cah4T4CnNfAqll61bxkFIPEa9ag6ONmjfueH36jjNfhpnTavh2BKqI5n1UfE+y15Q+/Ol
 5ELppPQli6OTTThlxGMts7tmIZLTS4fFCyzxGmsBYJcYLFzYZdeEX2ncIW8wtRzgYKoWmYNr
 gf8QQxcnpb4I1zNPw+Yv0UYz0kcrH25lDHtyjV1l2psta+DxGnVxPykchMbO2lNTW0kjFH2I
 IHygcpJOSrgJwUvihah4l73gqZBo6EqZUzaW0RVZG7bK294U62/nqWPaYhD5dl71EcfGPT5e
 l2cRrPn9lE/2jngAnAY6TQ1bTCstb3mkhY8hG/XfxMR5DLJPMp3wxnY/tnVQ/VciyEHSCdPg
 j7SHlGgPtOt8L14jr/7u/ulHyKkX5xXKmzwyJ+Y8TC8/StsCAG+mPa6npvmFxI72Gn1zYsiW
 SLNpRf6Ko7lssbyecduZEp1HxnR78RgG4dxupQ9jtcc1DAWi46U8nwOjWroeY8ChuShNjxUF
 GRNnI6d6ROtwEB5K3OV24/1MxfVitBsYdW3eCJe2y4w6dxLFLbB6bVFmSVvpV/r5QnVYPV7g
 nIc0a50sSFc3LtP4Vt3iHrNUdVwVQFCMCfhlgqF9YW7paRTPyO0dKSokVF5hZanBa2DpQdVX
 DD4fI0jFGl+9JYaUhqE3Xvt54XjYNSVY8gUs0jeth7ajPVObr81mOALgyVPJm/3+3Eogb1e7
 1QmzdShsY6LJn84toewGB1FLXvYY80J+zfipblTlICa0sr8e/cpUiVOV5zuQ/WyFTsUvvmyL
 AeCHgo3rXKDEKbeFwuSuw926mjCGJexOzSLNWEUmJ98EQKFKhUV02V2FH0q24Q0HQewyIn9f
 Vdls3oPs0XgpEIEw7BtMATjFHjSrkGkZ389Gp2YMQYT/g9F/VjcK8DY8e95WS1Vm//p5AXfL
 2uGe0FCCnwPUUHCGF3peLWjrdCS9u+FGq+1NPHTZbbI8OVYW67OzpWqt+kutz/eM8KSIjxpF
 PY8wFIFBHl/F52fkDIKAzoekyaHByKCjDG7/CA/7sW28fCwHRnq+ZPKELxKd9Nm5xGxh66Hc
 e+WnidwbzhChNsKwjfTxb4T0UR36WkmfiSxEbkGqS/GTb7B0q5RARkBbipvNcxOp6si1whJM
 MTfh5v7zLl9xvIyDl5EUxTmlKTLLYQSJHqhMVrcGEuRHLGBOCGN3Mz9J6+xCPVRgOhSqxysq
 GObHkvkbVHh33HiUxGiN/0JjTnOZkUB/t7nNE88Uy68HIGDCFXzKtJ8gDwozKdhg3rLMTVZK
 j1gawZWqaXW6ypEg/J5EmgH73x/LODClTzKiouQYpsQr/ZvBTx50uxA53FvgZ5c9iJZX7pYn
 CXIr9hhi06rmK+Dx3A0NXgG4iYOn4+NsUh4bO/B8YJcXH/f4B8XxWCXFghMuNZvTNHi8fM1q
 JCHhOf4LzFM9MjR9M0XCp3PKc6JB3EmNALgBD/eCAZtpd+DMGbCmwpCnfvU+nDH9vDST7Dzl
 ZBIRrIJDDTd+dsFB04jENFQef9K
IronPort-Data: A9a23:ljE8p68VmIacsfM125esDrUDzXqTJUtcMsCJ2f8bNWPcYEJGY0x3z
 TYYWmqDPP6CM2anf9h3bNu3/B5SuMCBxtdrGwFurH1EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNuspvlDs15K6v4WtA7gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi8udOZyemGaNNJl94pLMn1HKREmilJmGSx4fYOGfgvQo3P4sJEmig9jIZCEJ4yZ
 eJDMGUpM06GOkwVfAhHYH49tL/Aan3XVjRCq0+O44cz7XLSygNZz7XndtbYEjCPbZwPwRjC9
 zOcpgwVBDkdKN/B2xuHwk6Oud/+vR7VH5ACKeO3o6sCbFq7nTBDUEZGCjNXu8KRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyzmnN0cNFQNjUvk3rsU2RSIK8
 QSpx/q8UFSDr4appWShGqC8gR7aBMT4BWoFeDNCUgYPpdXuyG3Ssv4tZoc+eEJWpoeucd0V/
 9xshHVu71n0pZBTv5hXBXid31qRSmHhF2bZHDk7oV5JHisiON79PNz3gbQqxfdHKoGCBkKM1
 EU5dzylxLlWV/mlzXTdKM1URe3Bz6jealX03wUwd6TNAhz3oBZPi6gKu2kmfC+E868sJVfUX
 aMkkVgIvcAKYSv6NvMfjkDYI51C8JUM3O/NDpj8BueiqLAoLGdrJQk/OxDC7HOni0U2j6A0N
 LGSdMvmXz5QCr1qwHDyD60R2KMijHJ2j27CZ4HJ/zL+25qnZVmRVegkNnmKZbsH96+qmlje3
 OteEMqo8C9hdtPCTBPZyqMtCGwbDGMaAMn2ovNHd+TYLQtBHnogOsDrwrggWtJEmv1Lmtfx4
 33nZE58zWD7pHzYKDelbmJoR6PvUK1e81M6H30IFnS510czZb2A6P8kSKI2Wr085slP/OVRX
 dBcX+mhW9NhEi/m/RYZZrnD9L1STgyh31+yDnD0cQoBcI5FbC2X3N3dJy/E1jQEVwizvusA+
 4yQ7BvRG8c/dl4zHfTtSaydyn2qtiIgg8N0ZUzDJ+dTdGjK8IRHLy/QjOc9E/oTKCfslyer6
 AKLPSg2/eX9gZc50N3st5C2q42EF+hfHE0DO0L56b2wFzfR/0v94ItmfduLQwvgVzLPyP3/X
 dlW8vDyC+1YvVBot4EnLa1n45hj7PTSpphb7D9eIlP1U3qRBIldf0a2hft0ivUVx5tymxeHZ
 UaUy9wLZZSLIJzEFXASFioEb8OC96ompRjP39sIIWHRxix+zJyYW2p8YjiOjy18KuNuEYUHm
 O0Ohu8f2zaduDELbOmUqz9yzHudCEAAX4EMlIAoMKWyhiUFklh9MIHhUAno65SxWvBwG0gNI
 A7MopHdhr5Zl3HwQ1BqGVfjheNi1Ikz4jZUx1o/JnOMqNrPptkz+DZzqT0XbABk/i9r4tJJG
 FpAFhNKfP2V3jJSmsJ8cXimGFhBCD2n60XB8QY1u1ODfXa4dF7mDTMbAvmMznA74mgHXzl8/
 ZOk8kjHfwvuXvnM2noVZRY4hd3lFcd85y/TqvCBRs6lJaQ3URDho62pZFcLlSfZPNMMtBXHi
 NRurclNavzdFC8PoqcEJZGQ+pYORTulemFTY/FT05kYPGPbeT3o5zmqLnq1W8JSJs7l9V2zJ
 NxuK/luCTW/9neqhRIKCZEcJ4RbmKYS2+MDXbfwN0sqjqC6rAc1gKnP9yP7unAnc+9unek5N
 InVUTCISU6Uuld5hE7Pq5NiFlejQNxZejD54v+5wN8JG70HrutoV0M4iZmwnneNNTpY7wCmh
 xzCa4DW3t5d59xVxaW0KZp6BiKwNd/Xf8aL+lrqs91xMPX+Af2XvAYR8lTaLwBaOIUKYOtOl
 JOPjcXW2X3Ut7NnQkHbnJi8T5Ny3/uQZ9YOEMzLLyh9pxCgCf/cu05JvyjyLJFSi9pS6/W2X
 wbyOoP6adcRXMwb33FPLTRXFxEGEansc6P8vmWHou+RDgQGmxnyRD99GaQFsUkAHsPJB3H/N
 uMwk/Op+8wes4lGQhMJbx2j71mUP3e7MZbKtfWo3dVbMoVsqkyPsP3umHLMLBnVX2KcHp+SD
 Y3tH3DDmdfbhE0M5M5Uucp+s3X7yZq7bfYYJiogxjK9t9x24KPq4wjQ3VXqx6y4ShDP6aw=
IronPort-HdrOrdr: A9a23:QbH1na/+sYM4NvMqUAVuk+AGI+orL9Y04lQ7vn2ZOiYlFvBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhP1ICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:xVbOYmBJ6oyYTsD6ExZZxWEdQf0HSFjM1n3QI1GYLj1JEJTAHA==
X-Talos-MUID: 9a23:CaR2GQq4Bzbjr+8AhuMezzZ+N5l6wqaeNGIyoaQmhufDJzxNZTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,213,1754949600"; 
   d="scan'208";a="127629921"
X-MGA-submission: =?us-ascii?q?MDH5daBjSBLEt7tlX+/QaUHuBESO/ZgRJsha3B?=
 =?us-ascii?q?HbV7j6zM5X3rPsWVUohPW8vuK5V22xtO1BP2a1p0VP09IocE6K1a8ffZ?=
 =?us-ascii?q?xC7RRdZNORzDkKQfD2C1Ovx+AeAveLl8aChfjRnEaz+309t0yFuILc/Q?=
 =?us-ascii?q?wm3h3iX/GVZ2fC22qDpSUnXQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 15:31:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759930267; x=1760535067; i=markus.elfring@web.de;
	bh=DTroHWXO3np9YNLGPDFuczXSAENWfhOZ2u7weiLIE5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eGvjml+pEGjc0cz+a2/Neauyqz65PctABqn5Kch4j7SgUEq7RARLbDE+z9s/7oBY
	 enh4i34orRvJXEB8YB/N5hR0yIk8bI8JOX/daZAW5p0flZZ6AEDQ3nWrlLhnIaLyA
	 LarR5GpAlHRjdrKwXNh6fZQ8263CDS54QlwUOKOrRjbHZOQCZ8E4lrZMzLUkdpVEf
	 OmotzU2HiAhGsUt2klqe1N0tlrmAM3faDk5SnZG+U1KHnqBIApHfIF5I/efz7kNFe
	 BUPq+6ucluCNpPI/YUOpVMxDrXpJ50ZBwvkFZfY02fkZiq7fxXomDGB4uhwzzpzz1
	 Sg7V2lyjQS9adYNqTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1v2tcq2HGh-006KRx for
 <cocci@inria.fr>; Wed, 08 Oct 2025 15:31:07 +0200
Message-ID: <cb341887-c74c-4ba3-a8ee-7d83b6910e57@web.de>
Date: Wed, 8 Oct 2025 15:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <36f32079-1045-4913-9fff-3d1110b153c7@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <36f32079-1045-4913-9fff-3d1110b153c7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mn4vnQQWgghyDboLnz2oyX5ZN7IGE7iq7cwyS8iH5erkM/PXdET
 /Tuiv0KG06JqOuN8kyaUW0wJReHFEWoq1hfhNBVH8YvokSj814UreaW2yXp/1V01l3/Pfx5
 uaGKP/lle4f8u61dVNgjrS41lWCdNKWd+zyApbRxdJqYroj01GCpZjvh18luGTUlzbW6fPe
 ygsYYE6hO0sAvvEZ/4KFA==
UI-OutboundReport: notjunk:1;M01:P0:e4M0b20Dp/0=;nfVbIyx7cTL46BxtKF08r5Fil2C
 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
 O53Ij4RBRbp3QLv8IxhitcQq6hOHpi0XKn0=
Subject: Re: [cocci] Reconsidering condition check repetitions with help of
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3065
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/cb341887-c74c-4ba3-a8ee-7d83b6910e57%40web.de>

> Thus I tried the following SmPL script variant out.

Another SmPL script example for further development considerations:
// See also:
// smb2_compound_op()
// https://elixir.bootlin.com/linux/v6.17.1/source/fs/smb/client/smb2inode=
.c#L697-L748
@display@
expression e;
statement is, is2, es, es2;
@@
*if (e && ...)
    is
 else
    es
 <+... when !=3D e
*if (e)
    is2
 else
    es2
 ...+>


It looks promising on the first glance.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_questionable_condition_check_repetitions4.cocci
=E2=80=A6
No grep query


Unfortunately, the software run time characteristics are evolving into und=
esirable directions
so far.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops fs/smb/client/smb2inode.c =E2=80=A6/Projekte/Coccinelle=
/janitor/show_questionable_condition_check_repetitions4.cocci
=E2=80=A6
timeout (we abort)
Fatal error: exception Coccinelle_modules.Common.Timeout

real    3m20,475s
user    3m20,006s
sys     0m0,331s


Regards,
Markus
