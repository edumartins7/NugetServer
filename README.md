# NugetServer


Essa implementação adiciona a capacidade de configurar a URL padrão no Web.config e restringe o acesso ao Default.aspx para a rede local.

Isso é devido ao fato de que na implementação padrão é possível restringir apenas o "Push" de pacotes. O consumo de pacotes é sempre público e isso pode ser um problema.

O myget usa estratégia similiar (ter url confusa) para restringir o consumo de pacotes em feeds privados.