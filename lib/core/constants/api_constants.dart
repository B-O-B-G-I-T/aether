// Base URL
const String kBaseUrl = 'http://128.0.10.11:8080';

// Endpoints
const String kShopEndpoint = '/shop';
const String kArticlesEndpoint = '$kShopEndpoint/articles';
const String kArticlesTarifsEndpoint = '$kArticlesEndpoint/tarifs';

const String kArticleEndPoint = '$kShopEndpoint/article';
const String kCategoriesEndpoint = '$kShopEndpoint/categories';
const String kPanierEndpoint = '$kShopEndpoint/panier';
const String kUtilisateurEndpoint = '$kShopEndpoint/utilisateur';
const String kCommandesEndpoint = '$kShopEndpoint/commandes';
const String kCommandeEndpoint = "$kShopEndpoint/commande";
const String kBonCommandeEndpoint = "$kShopEndpoint/bon-commande";
const String kFacturesEndpoint = "$kShopEndpoint/factures";
const String kBLEndpoint = "$kShopEndpoint/bl";
const String kClientEndpoint = '$kShopEndpoint/client';

const String kConfigEndpoint = '$kShopEndpoint/config';
const String kCreneauxEndpoint = '$kConfigEndpoint/creneaux';

const String kPasswordEndpoint = '$kUtilisateurEndpoint/password';

// Full URLs
const String kGetArticlesUrl = '$kBaseUrl$kArticlesEndpoint';
const String kGetArticleDetailsUrl = '$kBaseUrl$kArticleEndPoint';
const String kGetArticlesTarifsUrl = '$kBaseUrl$kArticlesTarifsEndpoint';
const String kGetCategoriesUrl = '$kBaseUrl$kCategoriesEndpoint';
const String kGetPanierUrl = '$kBaseUrl$kPanierEndpoint';
const String kGetFavorisUrl = '$kBaseUrl$kArticlesEndpoint';
const String kToggleFavorisUrl = '$kBaseUrl$kArticleEndPoint';
const String kGetUtilisateurUrl = '$kBaseUrl$kUtilisateurEndpoint';
const String kGetClientUrl = '$kBaseUrl$kClientEndpoint';
const String kGetConfigUrl = '$kBaseUrl$kConfigEndpoint';
const String kGetCreneauxUrl = '$kBaseUrl$kCreneauxEndpoint';

const String kGetCommandesUrl = '$kBaseUrl$kCommandesEndpoint';
const String kGetCommandeUrl = '$kBaseUrl$kCommandeEndpoint';

const String kGetForgotPasswordUrl = '$kBaseUrl$kPasswordEndpoint';

// téléchargement PDF
const String kDownloadBordereauUrl = '$kBaseUrl$kBonCommandeEndpoint';
const String kDownloadBonLivraisonUrl = '$kBaseUrl$kBLEndpoint';
const String kDownloadFactureUrl = '$kBaseUrl$kFacturesEndpoint';

// Query Parameters
// commons
const String kGroupeFilleParam = 'groupeFille';
const String kSiteParam = 'site';
const String kTokenParam = 'token';

const String kClientParam = 'code';
const String kRechercheParam = 'recherche';
const String kArticleParam = 'article';
const String kConditionnementParam = 'conditionnement';
const String kQteCondParam = 'qteCond';
const String kTypeLivraisonParam = 'typeLivraison';
const String kDateLivraisonParam = 'dateLivraison';
const String kCategoriesParam = 'categories';
const String kArticlesParam = 'articles';
const String kFavorisParam = 'favoris';
const String kCadencierParam = 'cadencier';
const String kMercurialParam = 'mercurial';
const String kDepotParam = 'depot';
const String kModeParam = 'mode';
const String kLoginParam = 'login';
const String kPasswordParam = 'password';
const String kMailParam = 'mail';
const String kCodeSecuriteParam = 'codeSecurite';

// commandes
const String kDateFromParam = 'dateFrom';
const String kDateToParam = 'dateTo';

// téléchargement PDF params
const String kNoBordereauParam = 'noBordereau';
const String kNoLivraisonParam = 'noLivraison';
const String kNoFacturesParam = 'noFactures';
const String kSocieteParam = 'societe';
