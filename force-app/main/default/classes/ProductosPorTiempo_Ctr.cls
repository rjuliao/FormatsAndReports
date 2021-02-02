public with sharing class ProductosPorTiempo_Ctr {

    private Producto_Adquirido__c pc            {get; set;}
    private Id idProducto                       {get; set;}

    public ProductosPorTiempo_Ctr(ApexPages.StandardController controller) {
        this.idProducto = (id) controller.getId();
    }
}
