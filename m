From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 24 Jul 2015 19:30:46 +0200
Subject: [Cocci] sys.path for Python?
In-Reply-To: <20150724171759.GN30479@wotan.suse.de>
References: <CA+MoWDoKWWOpuUj=YoYWgVT73rOKhrcJPWCt_f-ro085D1T9cw@mail.gmail.com>
 <20150724171759.GN30479@wotan.suse.de>
Message-ID: <CA+MoWDpm2W+9k66du7M=U1ANkK+VW64DjqCrAypu4g8mVuauuQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Luis,

Thank you for the prompt reply.

> Can you try
>
> source_dir = os.path.abspath(os.path.dirname(__file__))
> sys.path.append(source_dir)

Looks like __file__  is not defined, but cocci.cocci_file contains the
path to the semantic patch, so:

source_dir = os.path.abspath(os.path.dirname(cocci.cocci_file))
sys.path.append(source_dir)

works perfectly fine! Thanks a lot!




-- 
Peter
