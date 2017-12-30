From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Dec 2017 16:00:47 -0200
Subject: [Cocci] coccicheck failed on Ubuntu 16.04
In-Reply-To: <alpine.DEB.2.20.1712301848150.9726@hadrien>
References: <CAOMZO5BpqrvDCEm8Z_bP+aO9Re2XJC+xjXpjrW1VARhPAHHoNw@mail.gmail.com>
 <alpine.DEB.2.20.1712301848150.9726@hadrien>
Message-ID: <CAOMZO5AdRa-N1X9bR1o6ALZ3RHNjOcZxK-ek_jsredvtG0xy4g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Sat, Dec 30, 2017 at 3:49 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Thanks for the report.  Could you try with V=1 and DEBUG_FILE=file.txt?
> Then it should be possible to find out more about what it is complaining
> about.
>
> Note that these options are mentioned in "Debugging Coccinelle SmPL
> patches" in Documentation/dev-tools/coccinelle.rst.  Otherwise, they are
> not so easy to remember...

Thanks for your hint. It was python-dev that was missing.

Now it is working fine.

Thanks
