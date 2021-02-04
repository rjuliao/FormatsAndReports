public with sharing class ProductosPorTiempo_Ctr {

    private Producto_Adquirido__c pc            {get; set;}
    private Id idProducto                       {get; set;}
    public List<Item> itemsAdq                  {get; set;}

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
    public List<Item> getInformation(){
        List<Item_de_compra__c> items = [SELECT ID, name, Cantidad__c,
                                            Precio_por_Unidad__c, Precio_total__c, Unidades__c,
                                            Quincena__r.Fecha_de_compra__c, Almacen__r.Name
                                            FROM Item_de_compra__c 
                                            WHERE Producto_Adquirido__c = :idProducto];

        List<Item> itemss = new List<Item>();       
        for (Item_de_compra__c itm : items) {
            
            Date fc = date.newinstance(itm.Quincena__r.Fecha_de_compra__c.year(), itm.Quincena__r.Fecha_de_compra__c.month(), itm.Quincena__r.Fecha_de_compra__c.day());
            String dateVal = String.valueOf(fc);
            Item i = new Item(itm.name, itm.Precio_por_Unidad__c, dateVal, itm.Almacen__r.Name);
            itemss.add(i);
        }

        

        if(!itemss.isEmpty()){
            System.debug('Items encontrados ' + itemss );
            return itemss;
        } else {
            return null;
        }
    }


    public class Item {
        public String name;
        public Decimal Cantidad;
        public Decimal Precio_por_Unidad;
        public Decimal Precio_total;
        public String Fecha_de_compra;
        public String nameAlm;

        public Item( String name, Decimal Precio_por_Unidad, String Fecha_de_compra, String nameAlm){
            this.name = name;
            this.Precio_por_Unidad = Precio_por_Unidad;
            this.Fecha_de_compra = Fecha_de_compra;
            this.nameAlm = nameAlm;
        }
    }

}
