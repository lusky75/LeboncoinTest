# LeboncoinTest

(Français)
Au lancement du projet, initialise la page Dashboard.

À la page Dashboard, s'il n'y a pas de produits ou catégories, requête la liste des produits ainsi que les catégories.
Les produits peuvent être filtrés par catégorie, et sont affichés dans l'ordre (si c'est urgent) ensuite triés par date.

Chaque produit contient une page de redirection vers ProductDetail. Permet d'afficher le contenu du produit et également de mettre en favoris le produit selectionné.

Les produits mis en favoris seront donc affichés dans Favoris.

(English)
At launch screen, initiate Dashboard page.
At Dashboard screen, if there is no products or categories. It requests list of products and categories.
Products can be sorted by selected categories and then it reload the data in order of (if it's urgent) then sorted by date.

Each product may contain a redirection to ProductDetail. It allows to display the content of product and of course pin the selected product to favorite.
Pined products are displayed at FavoriteProducts screen.

------------------

Concernant le projet: 
- Les assets, AppDelegate/SceneDelegate, et LaunchScreen: Application/

- Les components, extensions, et constants: Common/

- Les models: Models/Response/

- Les views, viewModels, controllers : Scenes/

- Les services API: Services/ServiceManager.swift


Les Unit Tests : LeboncoinTestModelTests/

Les UI Tests : LeboncoinTestUITests/
