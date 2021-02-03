public with sharing class ProductosPorTiempo_Ctr {

    private Producto_Adquirido__c pc            {get; set;}
    private Id idProducto                       {get; set;}
    public List<Item_de_compra__c> itemsAdq     {get; set;}

    public ProductosPorTiempo_Ctr(ApexPages.StandardController controller) {
        this.idProducto = (id) controller.getId();
        this.pc = getProducto();
        this.itemsAdq = getInformation();
    }


    public Producto_Adquirido__C getProducto(){
        list<Producto_Adquirido__c> lstpadq = [SELECT
                                           	Id, 
                                           	name,
                                           	Segmento__c
                                           	FROM Producto_Adquirido__c
                                           	WHERE id = :idProducto];
        if(!lstpadq.isEmpty()){
            system.debug('Producto a graficar'+lstpadq[0]);
            return lstpadq[0]; 
        }else{
            return null;
        }
    }

    //Get information of all the items related to the product
    public List<Item_de_compra__c> getInformation(){
        List<Item_de_compra__c> items = [SELECT ID, name, Cantidad__c,
                                            Precio_por_Unidad__c, Precio_total__c, Unidades__c,
                                            Quincena__c
                                            FROM Item_de_compra__c 
                                            WHERE Producto_Adquirido__c = :idProducto];

        Set<Id> itemsId = new Set<Id>();
        for (Item_de_compra__c item : items) {
            itemsId.add(item.id);
        }
        //List<Quincena__c>  comp = [SELECT Id, Name, Fecha_de_compra__c FROM Quincena__c WHERE Item_de_compra__c = :itemsId];
        
        for (Id itmid : itemsid) {
            
        }

        if(!items.isEmpty()){
            system.debug('Items encontrados ' + items );
            return items;
        } else {
            return null;
        }
    }
}
