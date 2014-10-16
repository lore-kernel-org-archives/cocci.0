From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 16 Oct 2014 15:56:11 +0200 (CEST)
Subject: [Cocci] Coccinelle rules for module_pci_driver
In-Reply-To: <543FB678.7000206@free-electrons.com>
References: <543FB678.7000206@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1410161554230.2585@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I suggest the following semantic patch.  It is in two parts.  The first
part matches all of the functions/declarations to ensure that they are all
present.  The second part then makes the transformation.

I get a change in only one file.

julia

// Find opportunities to use module_pci_driver(a)

@r1@
identifier f1, ret;
struct pci_driver a;
@@

int f1(void) {
  int ret;
  ret = pci_register_driver(&a);
  return ret;
}


@r2 depends on r1@
identifier f2;
struct pci_driver r1.a;
@@

void f2(void) {
pci_unregister_driver(&a);
}

@r3 depends on r2@
identifier r1.f1;
declarer name module_init;
@@

module_init(f1);

@r4 depends on r3@
identifier r2.f2;
declarer name module_exit;
@@

module_exit(f2);

// Clean up

@depends on r4@
identifier f1, ret;
struct pci_driver a;
@@

- int f1(void) {
-   int ret;
-   ret = pci_register_driver(&a);
-   return ret;
- }


@depends on r4@
identifier f2;
struct pci_driver r1.a;
@@

- void f2(void) {
-   pci_unregister_driver(&a);
- }

@depends on r4@
identifier r1.f1;
declarer name module_pci_driver;
@@

- module_init(f1);
+ module_pci_driver(&a);

@depends on r4@
identifier r2.f2;
@@

- module_exit(f2);
